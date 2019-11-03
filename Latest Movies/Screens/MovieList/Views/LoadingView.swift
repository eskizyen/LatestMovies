//
//  LoadingView.swift
//  Latest Movies
//
//  Created by Erkan Demir on 3.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    private let activityView = UIActivityIndicatorView(style: .whiteLarge)

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        activityView.startAnimating()
        activityView.backgroundColor = .darkGray
        activityView.layer.cornerRadius = 10
        addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        activityView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        activityView.sizeToFit()
    }
    
    override var isHidden: Bool {
        didSet {
            if isHidden {
                activityView.stopAnimating()
            } else {
                activityView.startAnimating()
            }
        }
    }
}
