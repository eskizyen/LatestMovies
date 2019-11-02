//
//  MovieListInteractor.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright (c) 2019 Erkan Demir. All rights reserved.
//

import UIKit

protocol MovieListBusinessLogic {
    
}

protocol MovieListDataStore {
    
}

class MovieListInteractor: MovieListBusinessLogic, MovieListDataStore {
    var presenter: MovieListPresentationLogic?
    var worker: MovieListWorker?
  
}
