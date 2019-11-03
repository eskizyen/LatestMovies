//
//  MovieListWorker.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit

class MovieListWorker {
    let movieFetcher: MovieFetcherProtocol
    
    init(movieFetcher: MovieFetcherProtocol) {
        self.movieFetcher = movieFetcher
    }
    
    func fetchLatestMovies(at page: Int) throws -> (pages: Int?, movies: [MovieEntity]) {
        return try movieFetcher.latestMovies(at: page)
    }
}
