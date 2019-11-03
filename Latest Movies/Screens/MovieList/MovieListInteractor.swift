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
        fetchLatestMovies()
    }
    
    func refresh() {
        currentPage = 1
        totalPages = nil
        isLoading = false
        isRefresh = true
        fetchLatestMovies()
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
                if isRefresh {
                    movies.removeAll()
                }
                
                currentPage += 1
                totalPages = response.pages
                movies += response.movies
                
                DispatchQueue.main.async {
                    if self.isRefresh {
                        self.isRefresh = false
                        self.presenter?.set(movies: response.movies, isLast: self.currentPage == self.totalPages)
                    } else {
                        self.presenter?.append(movies: response.movies, isLast: self.currentPage == self.totalPages)
                    }
                    
                    self.presenter?.state = self.movies.isEmpty ? .empty : .collection
                }
            }
        } catch let error {
            currentPage -= 1
            DispatchQueue.main.async {
                self.presenter?.showError(message: error.localizedDescription)
            }
        }
    }
}
