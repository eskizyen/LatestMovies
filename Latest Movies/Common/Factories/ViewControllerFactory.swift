//
//  ViewControllerFactory.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import UIKit

protocol ViewControllerFactoryProtocol {
    func movieList(with router: MovieListRouterProtocol, dependency: MovieList.Dependency) -> UIViewController
    func movieDetail() -> UIViewController
}

struct ViewControllerFactory: ViewControllerFactoryProtocol {
    static let shared = ViewControllerFactory()
    
    private init() { }
    
    func movieList(with router: MovieListRouterProtocol, dependency: MovieList.Dependency) -> UIViewController {
        let viewController = MovieListViewController(posterRatio: dependency.posterRatio)
        let interactor = MovieListInteractor(movieFetcher: dependency.movieFetcher)
        let presenter = MovieListPresenter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func movieDetail() -> UIViewController {
        let viewController = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
