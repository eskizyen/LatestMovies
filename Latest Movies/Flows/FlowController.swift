//
//  FlowController.swift
//  Latest Movies
//
//  Created by Erkan Demir on 2.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import UIKit

protocol FlowControllerProtocol: UIViewController {
    var dependency: DependencyFactoryProtocol { get }
}

class FlowController: UIViewController, FlowControllerProtocol {
    let dependency: DependencyFactoryProtocol
    
    init(dependency: DependencyFactoryProtocol) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(child: UIViewController) {
        child.willMove(toParent: self)
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = view.bounds
    }
}
