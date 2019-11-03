//
//  MovieDetailPresenter.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit

protocol MovieDetailPresentationLogic {
    func set(movie: MovieEntity)
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    weak var viewController: MovieDetailDisplayLogic?
    
    func set(movie: MovieEntity) {
        var originalTitle: String?
        
        if let title = movie.originalTitle, title != movie.prettyTitle() {
            originalTitle = "(\(title))"
        }
        
        viewController?.set(
            movie: MovieDetail.ViewModel(
                poster: movie.poster,
                backdrop: movie.backdrop,
                overview: movie.prettyOverview(),
                year: movie.prettyYear(),
                title: movie.prettyTitle() ?? "-",
                originalTitle: originalTitle,
                originalLanguage: movie.prettyOriginalLanguage(),
                rating: String(format: NSLocalizedString("Rating: %@", comment: "Rating %@"), movie.prettyRating())
            )
        )
    }
}
