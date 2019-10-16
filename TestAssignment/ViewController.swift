//
//  ViewController.swift
//  TestAssignment
//
//  Created by Bao Nguyen on 10/16/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLogo()
    }
    
    private func configureLogo() {
        view.addSubview(swiftLogo)
        swiftLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        swiftLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let views = [
            "swiftLogo" : swiftLogo
        ]
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[swiftLogo]",
                                                      metrics: nil,
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


}

