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
    func set(cells: [MovieList.Cell])
    func append(cells: [MovieList.Cell])
    func set(state: MovieList.StateViewModel)
}

class MovieListViewController: UIViewController, MovieListDisplayLogic {
    var interactor: MovieListBusinessLogic?
    var dataStore: MovieListDataStore?
    var router: MovieListRouterProtocol?
    let posterRatio: Float
    let viewHelper = MovieListViewHelper()

    // MARK: Object lifecycle
    init(posterRatio: Float) {
        self.posterRatio = posterRatio
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        viewHelper.build(in: self)
        
        viewHelper.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: MovieList.Cell.none.identifier())
        viewHelper.collectionView.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
        viewHelper.collectionView.register(UINib(nibName: LoadingCell.identifier, bundle: nil), forCellWithReuseIdentifier: LoadingCell.identifier)
        viewHelper.collectionView.delegate = self
        viewHelper.collectionView.dataSource = self

        viewHelper.emptyView.retryButton.addTarget(self, action: #selector(tapRetry), for: .touchUpInside)

        if #available(iOS 10.0, *) {
            viewHelper.collectionView.refreshControl = UIRefreshControl()
        }
        
        interactor?.fetchLatestMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let layout = viewHelper.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = floor((UIScreen.main.bounds.width - 10) / 3)
            layout.itemSize = CGSize(width: width, height: floor(width / CGFloat(posterRatio)))
            viewHelper.collectionView.setCollectionViewLayout(layout, animated: false)
        }
    }
    
    // MARK: Taps
    @objc private func tapRetry() {
        interactor?.reset()
    }
    
    // MARK: Display Logic
    func showError(message: String) {
        router?.alert(message: message)
    }
    
    private var cellModels = [MovieList.Cell]()
    
    func set(cells: [MovieList.Cell]) {
        if #available(iOS 10.0, *) {
            viewHelper.collectionView.refreshControl?.endRefreshing()
        }
        
        cellModels = cells
        viewHelper.collectionView.reloadData()
    }
    
    func append(cells: [MovieList.Cell]) {
        if let model = cellModels.last, model == .loading {
            cellModels.removeLast()
        }
        
        cellModels += cells
        
        viewHelper.collectionView.reloadData()
    }
    
    func set(state: MovieList.StateViewModel) {
        viewHelper.collectionView.isHidden = !state.isCollectionVisible
        viewHelper.loadingView.isHidden = !state.isLoaderVisible
        viewHelper.emptyView.isHidden = !state.isEmptyViewVisible
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = indexPath.row < cellModels.count ? cellModels[indexPath.row] : .none
        return collectionView.dequeueReusableCell(withReuseIdentifier: model.identifier(), for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row < cellModels.count else { return }
        let model = cellModels[indexPath.row]
        
        switch model {
        case .movie(let model):
            if let cell = cell as? MovieCell {
                cell.willDisplay(model: model)
            }
            
            if indexPath.row > cellModels.count - 10 {
                interactor?.fetchLatestMovies()
            }
        case .loading:
            if let cell = cell as? LoadingCell {
                cell.willDisplay()
            }
        case .none:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = dataStore?.movies, indexPath.row < movies.count else {
            return
        }
        
        router?.routeToMovieDetail(movies[indexPath.row])
    }
}

extension MovieListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if #available(iOS 10.0, *) {
            if let control = viewHelper.collectionView.refreshControl, control.isRefreshing {
                interactor?.refresh()
            }
        }
    }
}
