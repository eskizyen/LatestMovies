//
//  MovieListPresenter.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit

protocol MovieListPresentationLogic {
    func showError(message: String)
    func show(movies: [MovieEntity])
}

class MovieListPresenter: MovieListPresentationLogic {
    weak var viewController: MovieListDisplayLogic?
    
    func showError(message: String) {
        viewController?.showError(message: message)
    }
    
    func show(movies: [MovieEntity]) {
        for movie in movies {
            print("---")
            print(movie.poster?.absoluteString ?? "")
            print(movie.backdrop?.absoluteString ?? "")
        }
    }
}
