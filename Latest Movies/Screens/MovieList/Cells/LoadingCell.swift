//
//  LoadingCell.swift
//  Latest Movies
//
//  Created by Erkan Demir on 3.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import UIKit

class LoadingCell: UICollectionViewCell {
    static let identifier = "LoadingCell"
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func willDisplay() {
        activityIndicator.startAnimating()
    }
}
