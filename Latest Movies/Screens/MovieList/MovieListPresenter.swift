//
//  MovieListPresenter.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit

protocol MovieListPresentationLogic {
    var state: MovieList.State { get set }
    
    func showError(message: String)
    func append(movies: [MovieEntity])
    func appendLoader()
    func removeLoader()
}

class MovieListPresenter: MovieListPresentationLogic {
    weak var viewController: MovieListDisplayLogic?
    
    var state: MovieList.State = .loading {
        didSet {
            let model = MovieList.StateViewModel(
                isCollectionVisible: state == .collection,
                isLoaderVisible: state == .loading,
                isEmptyViewVisible: state == .empty
            )
            viewController?.set(state: model)
        }
    }
    
    func showError(message: String) {
        viewController?.showError(message: message)
    }
    
    func append(movies: [MovieEntity]) {
        var cells = [MovieList.Cell]()
        
        for movie in movies {
            cells.append(
                .movie(
                    model: MovieCell.ViewModel(
                        poster: movie.poster,
                        title: movie.anyTitle()
                    )
                )
            )
        }
        
        viewController?.append(cells: cells)
    }
    
    func appendLoader() {
        viewController?.append(cells: [.loading])
    }
    
    func removeLoader() {
        viewController?.removeLoadingCell()
    }
}
