//
//  MainFlowController.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import UIKit

class MoviesFlowController: FlowController {
    let navigation = UINavigationController()
    
    override init(dependency: DependencyFactoryProtocol) {
        super.init(dependency: dependency)
        add(child: navigation)
        list(animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Routing
    private func list(animated: Bool) {
        navigation.pushViewController(
            dependency.viewFactory.movieList(
                with: self,
                dependency: MovieList.Dependency(
                    movieFetcher: dependency.movieFetcher,
                    posterRatio: dependency.posterRatio
                )
            ),
            animated: animated
        )
    }
    
    private func detail(_ movie: MovieEntity, animated: Bool) {
        navigation.pushViewController(
            dependency.viewFactory.movieDetail(movie),
            animated: animated
        )
    }

}

// MARK: - MovieListRouterProtocol
extension MoviesFlowController: MovieListRouterProtocol {
    func routeToMovieDetail(_ movie: MovieEntity) {
        detail(movie, animated: true)
    }
}
