//
//  MovieDBDiscoverMovieMethod.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import Foundation

extension MovieDB {
    struct DiscoverMovieMethod {
        let query: Query
        
        struct Query: Encodable {
            let api_key: String
            let page: Int
            let sort_by: String
            let language: String?
        }
        
        struct Response: Decodable {
            let page: Int?
            let total_results: Int?
            let total_pages: Int?
            let results: [Movie]?
            
            struct Movie: Decodable {
                let poster_path: String?
                let adult: Bool?
                let overview: String?
                let release_date: Date?
                let genre_ids: [Int]?
                let id: Int?
                let original_title: String?
                let original_language: String?
                let title: String?
                let backdrop_path: String?
                let popularity: Float?
                let vote_count: Int?
                let video: Bool?
                let vote_average: Float?
            }
        }
        
        func send(with request: Remote.Request) throws -> Response {
            return try Remote.Request(with: request)
                .set(method: .get)
                .set(url: request.url?.appendingPathComponent("discover/movie"), query: query)
                .send()
        }
    }
}
