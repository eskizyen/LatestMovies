//
//  MovieEntity.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import Foundation

struct MovieEntity {
    let poster: URL?
    let backdrop: URL?
    let title: String?
    let originalTitle: String?
    let overview: String?
    let rating: Float?
    let releaseDate: Date?
    let originalLanguage: String?
    
    func prettyTitle() -> String? {
        return title ?? originalTitle
    }
    
    func prettyOverview() -> String {
        return overview ?? "-"
    }
    
    func prettyYear() -> String {
        guard let date = releaseDate else { return "-" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    func prettyRating() -> String {
        guard let rating = rating else { return "-" }
        return String(format: "%.1f", rating)
    }
    
    func prettyOriginalLanguage() -> String {
        guard let language = originalLanguage else { return "-" }
        return Locale.current.localizedString(forIdentifier: language) ?? "-"
    }
}
