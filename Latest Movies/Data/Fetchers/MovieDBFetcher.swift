//
//  MovieDBFetcher.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import Foundation

protocol MovieFetcherProtocol {
    func latestMovies(at page: Int) throws -> (pages: Int?, movies: [MovieEntity])
}

class MovieDBFetcher: MovieFetcherProtocol {
    static let shared = MovieDBFetcher()
    private let posterUrl = URL(string: "https://image.tmdb.org/t/p/w342")
    private let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w1280")
    
    func latestMovies(at page: Int) throws -> (pages: Int?, movies: [MovieEntity]) {
        let response = try MovieDB.shared.latestMovies(at: page)
        var movies = [MovieEntity]()
        
        for movie in response.results ?? [] {
            var poster: URL?
            var backdrop: URL?
            
            if let path = movie.poster_path {
                poster = posterUrl?.appendingPathComponent(path)
            }
            
            if let path = movie.backdrop_path {
                backdrop = backdropUrl?.appendingPathComponent(path)
            }
            
            movies.append(
                MovieEntity(
                    poster: poster,
                    backdrop: backdrop,
                    title: movie.title,
                    originalTitle: movie.original_title,
                    overview: movie.overview,
                    rating: movie.vote_average,
                    releaseDate: movie.release_date,
                    originalLanguage: movie.original_language
                )
            )
        }
        
        return (pages: response.total_pages, movies: movies)
    }
}
