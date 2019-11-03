//
//  MovieDetailViewController.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit
import SDWebImage

protocol MovieDetailDisplayLogic: class {
    func set(movie: MovieDetail.ViewModel)
}

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic {
    var interactor: MovieDetailBusinessLogic?
    private let gradient = CAGradientLayer()

    @IBOutlet weak var backdropShadowView: UIView!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    // MARK: Object lifecycle
    init() {
        super.init(nibName: "MovieDetailViewController", bundle: nil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    private func setup() {
        
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        backdropShadowView.layer.addSublayer(gradient)
        backdropShadowView.clipsToBounds = true

        interactor?.fetchMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = backdropShadowView.bounds
    }
    
    // MARK: Display Logic
    func set(movie: MovieDetail.ViewModel) {
        title = movie.title
        load(url: movie.backdrop, to: backdropView)
        load(url: movie.poster, to: posterView)
        titleLabel.text = movie.title
        originalTitleLabel.text = movie.originalTitle
        yearLabel.text = movie.year
        languageLabel.text = movie.originalLanguage
        ratingLabel.text = movie.rating
        overviewLabel.text = movie.overview
    }
    
    private func load(url: URL?, to imageView: UIImageView) {
        SDWebImageManager.shared.loadImage(
            with: url,
            options: [],
            progress: { [weak self] (received, expected, _) in
                guard let `self` = self else { return }
                
                if received == expected {
                    DispatchQueue.main.async {
                        self.animate(imageView: imageView)
                    }
                }
            },
            completed: { [weak self] (image, _, _, cacheType, _, _) in
                guard let `self` = self else { return }
                
                imageView.image = image
                
                if cacheType == .disk {
                    self.animate(imageView: imageView)
                }
            }
        )
    }
    
    private func animate(imageView: UIImageView) {
        imageView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            imageView.alpha = 1.0
        }
    }
  
}
