//
//  MovieDBDecoder.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import Foundation

struct MovieDBDecoder: RemoteDecoderProtocol {
    struct DateDecodingStrategy {
        static var `default`: JSONDecoder.DateDecodingStrategy {
            return .custom({ (decoder) -> Date in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                guard let date = dateFormatter.date(from: dateString) else {
                    return Date(timeIntervalSinceReferenceDate: 0)
                }
                
                return date
            })
        }
    }
    
    func decode<T: Decodable>(data: Data, urlResponse: URLResponse) throws -> T {
        guard let response = urlResponse as? HTTPURLResponse else { throw Remote.Error.unknown }
        guard response.statusCode == 200 else {
            let decoder = JSONDecoder()
            
            var movieDBError: MovieDB.Error?
            
            do {
                movieDBError = try decoder.decode(MovieDB.Error.self, from: data)
            } catch let error {
                throw Remote.Error.decode(data: data, underlyingError: error)
            }
            
            guard let error = movieDBError else {
                throw Remote.Error.unknown
            }
            
            throw Remote.Error.movieDB(error)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = DateDecodingStrategy.default
        return try decoder.decode(T.self, from: data)
    }
}
