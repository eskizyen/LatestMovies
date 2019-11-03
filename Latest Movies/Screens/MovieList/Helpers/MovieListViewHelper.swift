//
//  MovieListViewHelper.swift
//  Latest Movies
//
//  Created by Erkan Demir on 3.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import UIKit

class MovieListViewHelper {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        return view
    }()
    
    let emptyView = EmptyView()
    let loadingView = LoadingView()
    
    func build(in viewController: UIViewController) {
        addCollectionView(in: viewController)
        addLoadingView(in: viewController)
        addEmptyView(in: viewController)
    }
    
    private func addCollectionView(in viewController: UIViewController) {
        collectionView.isHidden = true
        viewController.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: viewController.topLayoutGuide.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor).isActive = true
    }
    
    private func addLoadingView(in viewController: UIViewController) {
        loadingView.isHidden = true
        viewController.view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: viewController.topLayoutGuide.bottomAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor).isActive = true
    }

    private func addEmptyView(in viewController: UIViewController) {
        emptyView.isHidden = true
        viewController.view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: viewController.topLayoutGuide.bottomAnchor).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor).isActive = true
    }
}
