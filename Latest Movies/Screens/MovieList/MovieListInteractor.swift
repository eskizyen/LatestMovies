//
//  MovieListInteractor.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit

protocol MovieListBusinessLogic {
    func fetchLatestMovies(at page: Int)
}

protocol MovieListDataStore {
    var movies: [MovieEntity] { get }
}

class MovieListInteractor: MovieListBusinessLogic, MovieListDataStore {
    var presenter: MovieListPresentationLogic?
    var worker: MovieListWorker?
    var movies = [MovieEntity]()
    
    private var totalPages: Int?
    
    init(movieFetcher: MovieFetcherProtocol) {
        worker = MovieListWorker(movieFetcher: movieFetcher)
    }
  
    func fetchLatestMovies(at page: Int) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            do {
                if let response = try self?.worker?.fetchLatestMovies(at: page) {
                    self?.totalPages = response.pages
                    self?.movies += response.movies
                    
                    DispatchQueue.main.async {
                        guard let `self` = self else { return }
                        self.presenter?.show(movies: self.movies)
                    }
                }
            } catch let error {
                DispatchQueue.main.async {
                    self?.presenter?.showError(message: error.localizedDescription)
                }
            }
        }
    }
}
