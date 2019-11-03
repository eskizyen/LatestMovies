//
//  MovieDetailInteractor.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit

protocol MovieDetailBusinessLogic {
    func fetchMovie()
}

protocol MovieDetailDataStore {

}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore {
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorker?
    private let movie: MovieEntity
    
    init(_ movie: MovieEntity) {
        self.movie = movie
    }
    
    func fetchMovie() {
        presenter?.set(movie: movie)
    }
}
