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

protocol AlertProtocol {
    func alert(message: String?)
    func alert(title: String?, message: String?)
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

extension FlowController: AlertProtocol {
    func alert(message: String?) {
        alert(title: nil, message: message)
    }
    
    func alert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Alert ok title"), style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
