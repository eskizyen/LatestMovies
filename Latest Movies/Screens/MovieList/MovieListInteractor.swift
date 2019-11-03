//
//  MovieListInteractor.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit

protocol MovieListBusinessLogic {
    func reset()
    func refresh()
    func fetchLatestMovies()
}

protocol MovieListDataStore {
    var movies: [MovieEntity] { get }
}

class MovieListInteractor: MovieListBusinessLogic, MovieListDataStore {
    var presenter: MovieListPresentationLogic?
    var worker: MovieListWorker?
    var movies = [MovieEntity]()
    
    private var totalPages: Int?
    private var currentPage = 1
    private var isLoading = false
    private var isRefresh = false
    
    init(movieFetcher: MovieFetcherProtocol) {
        worker = MovieListWorker(movieFetcher: movieFetcher)
    }
    
    func reset() {
        currentPage = 1
        totalPages = nil
        isLoading = false
        isRefresh = false
        movies.removeAll()
    }
    
    func refresh() {
        currentPage = 1
        totalPages = nil
        isLoading = false
        isRefresh = true
    }
  
    func fetchLatestMovies() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let `self` = self else { return }
            guard
                !self.isLoading,
                self.currentPage < (self.totalPages ?? Int.max)
                else { return }

            DispatchQueue.main.async {
                if self.movies.isEmpty {
                    self.presenter?.state = .loading
                } else {
                    self.presenter?.appendLoader()
                }
            }
            
            self.isLoading = true
            self.fetchMovies(at: self.currentPage)
            self.isLoading = false
        }
    }
    
    private func fetchMovies(at page: Int) {
        do {
            if let response = try self.worker?.fetchLatestMovies(at: self.currentPage) {
                if self.isRefresh {
                    self.isRefresh = false
                    self.movies.removeAll()
                }
                
                self.currentPage += 1
                self.totalPages = response.pages
                self.movies += response.movies
                
                DispatchQueue.main.async {
                    self.presenter?.removeLoader()
                    self.presenter?.append(movies: response.movies)
                    self.presenter?.state = self.movies.isEmpty ? .empty : .collection
                }
            }
        } catch let error {
            self.currentPage -= 1
            DispatchQueue.main.async {
                self.presenter?.showError(message: error.localizedDescription)
            }
        }
    }
}
