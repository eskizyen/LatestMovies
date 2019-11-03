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
    func set(movies: [MovieEntity], isLast: Bool)
    func append(movies: [MovieEntity], isLast: Bool)
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
    
    func set(movies: [MovieEntity], isLast: Bool) {
        viewController?.set(cells: cells(movies: movies))
        
        if !isLast {
            viewController?.append(cells: [.loading])
        }
    }
    
    func append(movies: [MovieEntity], isLast: Bool) {
        viewController?.append(cells: cells(movies: movies))
        
        if !isLast {
            viewController?.append(cells: [.loading])
        }
    }
    
    private func cells(movies: [MovieEntity]) -> [MovieList.Cell] {
        var cells = [MovieList.Cell]()
        
        for movie in movies {
            cells.append(
                .movie(
                    model: MovieCell.ViewModel(
                        poster: movie.poster,
                        title: movie.prettyTitle()
                    )
                )
            )
        }
        
        return cells
    }
}
