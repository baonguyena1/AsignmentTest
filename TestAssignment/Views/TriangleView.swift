//
//  TriangleView.swift
//  TestAssignment
//
//  Created by Bao Nguyen on 10/16/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import UIKit

@IBDesignable
class TriangleView: UIView {
    
    @IBInspectable var fillColor: UIColor = .clear {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let triaglePath = self.triaglePath()
        triaglePath.lineWidth = 1.0
        let triagleLayer = CAShapeLayer()
        triagleLayer.frame = bounds
        triagleLayer.path = triaglePath.cgPath
        triagleLayer.fillColor = fillColor.cgColor
        layer.addSublayer(triagleLayer)
    }

    private func triaglePath() -> UIBezierPath {
        let width = bounds.width
        let height = bounds.height
        let path = UIBezierPath()
        let topCenter = CGPoint(x: width/2.0, y: 0)
        path.move(to: topCenter)
        let rightBottom = CGPoint(x: width, y: height)
        path.addLine(to: rightBottom)
        let leftBottom = CGPoint(x: 0, y: height)
        path.addLine(to: leftBottom)
        path.close()
        return path
    }
}
