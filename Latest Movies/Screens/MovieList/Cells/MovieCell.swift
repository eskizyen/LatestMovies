//
//  MovieCell.swift
//  Latest Movies
//
//  Created by Erkan Demir on 3.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    static let identifier = "MovieCell"
    
    struct ViewModel {
        let poster: URL?
        let title: String?
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var posterFrameView: UIView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var model: ViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterFrameView.layer.borderWidth = 1.0
        posterFrameView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func willDisplay(model: ViewModel) {
        self.model = model
        titleLabel.text = model.title
        
        activityIndicator.startAnimating()
        posterView.image = nil
        
        SDWebImageManager.shared.loadImage(
            with: model.poster,
            options: [],
            progress: { [weak self] (received, expected, _) in
                guard let `self` = self else { return }
                
                if received == expected {
                    DispatchQueue.main.async {
                        self.animatePoster()
                    }
                }
            },
            completed: { [weak self] (image, _, _, cacheType, _, url) in
                guard let `self` = self else { return }
                guard self.model?.poster == url else { return }
                
                self.activityIndicator.stopAnimating()
                self.posterView.image = image
                
                if cacheType == .disk {
                    self.animatePoster()
                }
            }
        )
    }
    
    private func animatePoster() {
        self.posterView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.posterView.alpha = 1.0
        }
    }
}
