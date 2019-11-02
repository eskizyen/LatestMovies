//
//  Remote.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import Foundation

struct Remote {
    enum Error: LocalizedError {
        case unknown
        case nilResponse
        case noContent
        case decode(data: Data, underlyingError: Swift.Error)
        case movieDB(MovieDB.Error)

        public var errorDescription: String? {
            switch self {
            case .unknown:
                return "Unknown Error"
            case .nilResponse:
                return "No response"
            case .noContent:
                return "No content"
            case .decode(_, let underlyingError):
                return underlyingError.localizedDescription
            case .movieDB(let error):
                return error.status_message
            }
        }
    }
}
