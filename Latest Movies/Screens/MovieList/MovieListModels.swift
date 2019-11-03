//
//  MovieListModels.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit

enum MovieList {
    struct Dependency {
        let movieFetcher: MovieFetcherProtocol
        let posterRatio: Float
    }
    
    enum State {
        case collection
        case empty
        case loading
    }
    
    struct StateViewModel {
        let isCollectionVisible: Bool
        let isLoaderVisible: Bool
        let isEmptyViewVisible: Bool
    }
    
    enum Cell: Equatable {
        case none
        case movie(model: MovieCell.ViewModel)
        case loading
        
        func identifier() -> String {
            switch self {
            case .none:
                return "Empty"
            case .movie:
                return MovieCell.identifier
            case .loading:
                return LoadingCell.identifier
            }
        }
        
        static func == (lhs: Cell, rhs: Cell) -> Bool {
            switch (lhs, rhs) {
            case (.movie, .movie):
                return true
            case (.loading, .loading):
                return true
            case (.none, .none):
                return true
            default:
                return false
            }
        }
    }
}
