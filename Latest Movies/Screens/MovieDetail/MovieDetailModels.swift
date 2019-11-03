//
//  MovieDetailModels.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit

enum MovieDetail {
    struct ViewModel {
        let poster: URL?
        let backdrop: URL?
        let overview: String
        let year: String
        let title: String
        let originalTitle: String?
        let originalLanguage: String
        let rating: String
    }
}
