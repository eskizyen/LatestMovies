//
//  MovieListViewController.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit

protocol MovieListDisplayLogic: class {
    func showError(message: String)
}

class MovieListViewController: UITableViewController, MovieListDisplayLogic {
    var interactor: MovieListBusinessLogic?
    var router: MovieListRouterProtocol?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    private func setup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Detail",
            style: .plain,
            target: self,
            action: #selector(tapDetail)
        )
        title = "Movie List"
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchLatestMovies(at: 1)
    }
    
    @objc private func tapDetail() {
        router?.routeToMovieDetail()
    }
    
    // MARK: Display Logic
    func showError(message: String) {
        router?.alert(message: message)
    }
}
