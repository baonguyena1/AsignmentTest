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
        guard let image = generateImage(),
            let ciImage = CIImage(image: image),
            let filter = CIFilter(name: "CIGaussianBlur") else {
            return
        }
        // Get Gaussian Blur image from image get from view
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(radius, forKey: kCIInputRadiusKey)
        guard let outputImage = filter.value(forKey: kCIOutputImageKey) as? CIImage else { return }
        let context = CIContext(options: nil)
        guard let cgimg = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let filteredImage = UIImage(cgImage: cgimg)
        
        /**
        ** Because the TriagleView is draw in Core Graphics, so I can't use the normal method for display blur view.
        ** Because Core graphics is overlapped the subviews
        ** so I create new overlay view and present it
        **/
        let boundingRect = outputImage.extent
        let blurView = UIImageView(image: filteredImage)
        blurView.frame = boundingRect
        blurView.contentMode = .scaleAspectFit
        blurView.clipsToBounds = false
        blurView.center = self.center
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
        guard let outputImage = filter.value(forKey: kCIOutputImageKey) as? CIImage else { return nil }
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
    
    
    /// Remove previous the blur view
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
    
    
    /// Using Objective-C Runtime for store the blur view
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
