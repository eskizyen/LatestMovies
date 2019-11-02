//
//  AppFlowController.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import UIKit

class AppFlowController: FlowController {
    let navigation = UINavigationController()
    
    override init(dependency: DependencyFactoryProtocol) {
        super.init(dependency: dependency)
        add(child: navigation)
        navigation.setNavigationBarHidden(true, animated: false)
        movies(animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func movies(animated: Bool) {
        navigation.pushViewController(
            MoviesFlowController(dependency: dependency),
            animated: animated
        )
    }

}
