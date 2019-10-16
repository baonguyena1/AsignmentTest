//
//  UIView+Helper.swift
//  TestAssignment
//
//  Created by Bao Nguyen on 10/16/19.
//  Copyright © 2019 Bao Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    private struct AssociatedKeys {
        static var blurView = "blurView"
    }
    
    func blur(radius: CGFloat) {
        unBlur()
        let filteredImage = blueImage(radius: radius)
        let blurView = UIImageView(image: filteredImage)
        blurView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        blurView.frame.origin = frame.origin
        blurView.contentMode = .scaleAspectFill
        UIView.transition(from: self,
                          to: blurView,
                          duration: 0.2,
                          options: .curveEaseIn,
                          completion: nil)
        self.blurView = blurView
    }
    
    private func blueImage(radius: CGFloat) -> UIImage? {
        guard let image = generateImage(),
            let ciImage = CIImage(image: image),
            let filter = CIFilter(name: "CIGaussianBlur") else {
            return nil
        }
        // Set Blur filter image from image get from view
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(radius, forKey: kCIInputRadiusKey)
        guard let outputImage = filter.outputImage else { return nil }
        let context = CIContext(options: nil)
        guard let cgimg = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return UIImage(cgImage: cgimg)
    }
    
    private func generateImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 1)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    private func unBlur() {
        if let blurView = self.blurView {
            UIView.transition(from: blurView,
                              to: self,
                              duration: 0.2,
                              options: .curveEaseIn,
                              completion: nil)
            self.blurView = nil
        }
    }
    
    private var blurView: UIImageView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.blurView) as? UIImageView
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.blurView,
                newValue as UIImageView?,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
