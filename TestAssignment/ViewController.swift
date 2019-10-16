//
//  ViewController.swift
//  TestAssignment
//
//  Created by Bao Nguyen on 10/16/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let topSpace: CGFloat = 60.0
    
    private lazy var swiftLogo: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "swift_logo.png"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var redTriagle: TriangleView = {
        let view = TriangleView()
        view.fillColor = #colorLiteral(red: 0.8823529412, green: 0.03921568627, blue: 0.03921568627, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var greenTriagle: TriangleView = {
        let view = TriangleView()
        view.fillColor = #colorLiteral(red: 0.4117647059, green: 0.6901960784, blue: 0.9215686275, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var itemWidth: CGFloat = {
        return self.view.frame.width * 1/3
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRedView()
        configureGreenView()
        configureLogo()
    }
    
    private func configureLogo() {
        view.addSubview(swiftLogo)
        swiftLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        swiftLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let views = [
            "swiftLogo" : swiftLogo
        ]
        let metrics = [
            "topSpace": topSpace
        ]
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(topSpace)-[swiftLogo]",
                                                      metrics: metrics,
                                                      views: views)
        constraints.append(NSLayoutConstraint(item: swiftLogo,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: swiftLogo,
                                              attribute: .width,
                                              multiplier: 1.0,
                                              constant: 0.0))
        NSLayoutConstraint.activate(constraints)
    }

    private func configureRedView() {
        view.addSubview(redTriagle)
        let redTopSpace = topSpace + itemWidth / 2
        redTriagle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        redTriagle.trailingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        var constraints = [NSLayoutConstraint]()
        let views = [
            "redTriagle": redTriagle
        ]
        let metrics = [
            "redTopSpace": redTopSpace
        ]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(redTopSpace)-[redTriagle]",
                                                      metrics: metrics,
                                                      views: views)
        constraints.append(NSLayoutConstraint(item: redTriagle,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: redTriagle,
                                              attribute: .width,
                                              multiplier: 1.0,
                                              constant: 0.0))
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureGreenView() {
        view.addSubview(greenTriagle)
        let greenTopSpace = topSpace + itemWidth
        greenTriagle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        greenTriagle.leadingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        var constraints = [NSLayoutConstraint]()
        let views = [
            "greenTriagle": greenTriagle
        ]
        let metrics = [
            "greenTopSpace": greenTopSpace
        ]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(greenTopSpace)-[greenTriagle]",
                                                      metrics: metrics,
                                                      views: views)
        constraints.append(NSLayoutConstraint(item: greenTriagle,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: greenTriagle,
                                              attribute: .width,
                                              multiplier: 1.0,
                                              constant: 0.0))
        NSLayoutConstraint.activate(constraints)
    }
}

