//
//  MovieDB.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import Foundation

class MovieDB: Remote.Endpoint {
    static let shared = MovieDB()
    
    private let apiKey = "9d6c12984d0f343f78cbe5c3cfddcd4b"

    override init() {
        super.init()
        baseRequest.set(url: URL(string: "https://api.themoviedb.org/3"))
        baseRequest.set(decoder: MovieDBDecoder())
    }
    
    func latestMovies(at page: Int) throws -> MovieDB.DiscoverMovieMethod.Response {
        let query = DiscoverMovieMethod.Query(
            api_key: apiKey,
            page: page,
            sort_by: "release_date.desc",
            language: Locale.current.languageCode
        )
        
        return try DiscoverMovieMethod(query: query).send(with: baseRequest)
        
    }
}

extension MovieDB {
    struct Error: Decodable {
        let status_message: String
        let status_code: Int?
    }
}
