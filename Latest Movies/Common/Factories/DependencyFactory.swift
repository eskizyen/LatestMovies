//
//  DependencyFactory.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import Foundation

protocol DependencyFactoryProtocol {
    var viewFactory: ViewControllerFactoryProtocol { get }
}

struct DependencyFactory: DependencyFactoryProtocol {
    var viewFactory: ViewControllerFactoryProtocol {
        ViewControllerFactory.shared
    }
}