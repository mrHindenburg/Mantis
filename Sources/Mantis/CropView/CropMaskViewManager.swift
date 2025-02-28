//
//  CropMaskViewManager.swift
//  Mantis
//
//  Created by Echo on 10/28/18.
//  Copyright © 2018 Echo. All rights reserved.
//

import UIKit

final class CropMaskViewManager {
    private let dimmingView: CropMaskProtocol
    private let visualEffectView: CropMaskProtocol
    private(set) var maskViews: [CropMaskProtocol]
    private var cropBoxFrame: CGRect

    
    
    init(dimmingView: CropMaskProtocol,
         visualEffectView: CropMaskProtocol, cropBoxFrame: CGRect) {
        self.dimmingView = dimmingView
        self.visualEffectView = visualEffectView
        self.cropBoxFrame = cropBoxFrame
        maskViews = [dimmingView]
    }
    
    private func updateDimmingMask() {
        guard let superview = dimmingView.superview else { return }

        if dimmingView.frame != cropBoxFrame {
            dimmingView.frame = cropBoxFrame
        }
        let path = UIBezierPath(rect: CGRect(origin: .zero, size: cropBoxFrame.size))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .nonZero

            self.dimmingView.layer.mask = maskLayer
    }
        
    private func showDimmingBackground() {
        dimmingView.alpha = 1
        visualEffectView.alpha = 0
        updateDimmingMask()
    }

    private func showVisualEffectBackground() {
        self.dimmingView.alpha = 0
        self.visualEffectView.alpha = 0
    }
}

extension CropMaskViewManager: CropMaskViewManagerProtocol {
    func setup(in view: UIView, cropRatio: CGFloat = 1.0) {
        maskViews.forEach { maskView in
            maskView.initialize(cropRatio: cropRatio)
            maskView.isUserInteractionEnabled = false
            view.addSubview(maskView)
        }

        showVisualEffectBackground()
    }
    
    func removeMaskViews() {
        maskViews.forEach { $0.removeFromSuperview() }
    }
    
    func showDimmingBackground(animated: Bool) {
        
        showDimmingBackground()
    }
//        if animated {
//            UIView.animate(withDuration: 0.1) {
//                showDimmingBackground()
//               
//            }
//        } else {
//            showDimmingBackground()
//        }
//    }
    
    func showVisualEffectBackground(animated: Bool) {
//        if animated {
//            UIView.animate(withDuration: 0.5) {
//                self.showVisualEffectBackground()
//            }
//        } else {
//            showVisualEffectBackground()
//        }
    }
    
//    func adaptMaskTo(match cropRect: CGRect, cropRatio: CGFloat) {
//       maskViews.forEach { $0.adaptMaskTo(match: cropRect, cropRatio: cropRatio) }
//            //self.cropBoxFrame = cropRect
//    }
    
    func adaptMaskTo(match cropRect: CGRect, cropRatio: CGFloat) {
        self.cropBoxFrame = cropRect
        dimmingView.frame = cropBoxFrame
        updateDimmingMask()
    }

}
