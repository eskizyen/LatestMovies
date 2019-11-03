//
//  EmptyView.swift
//  Latest Movies
//
//  Created by Erkan Demir on 3.11.2019.
//  Copyright © 2019 Erkan Demir. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    private let containerView = UIView()
    private let label = UILabel()
    let retryButton = UIButton(type: .system)

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        retryButton.setTitle(NSLocalizedString("Retry", comment: "Retry list loading"), for: .normal)
        retryButton.sizeToFit()
        
        label.text = NSLocalizedString("Couldn't retrieve the latest movies", comment: "Empty view message")
        label.sizeToFit()
        
        addContainer()
        addContainerChildren()
    }
    
    private func addContainer() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    private func addContainerChildren() {
        label.textAlignment = .center
        label.numberOfLines = 0
        containerView.addSubview(label)
        containerView.addSubview(retryButton)
        label.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        let views = [
            "label": label,
            "button": retryButton
        ]
        var allConstraints = [NSLayoutConstraint]()
        
        allConstraints.append(
            contentsOf: NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[label]-10-[button]|",
                options: .alignAllCenterX,
                metrics: nil,
                views: views
            )
        )
        
        NSLayoutConstraint.activate(allConstraints)
        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }

}
