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
        
    private func showDimmingBackground() {
        dimmingView.alpha = 1
        visualEffectView.alpha = 0
        print(cropBoxFrame)
        //dimmingView.frame = cropBoxFrame
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
    
    func adaptMaskTo(match cropRect: CGRect, cropRatio: CGFloat) {
        self.cropBoxFrame = cropRect
       maskViews.forEach { $0.adaptMaskTo(match: cropRect, cropRatio: cropRatio) }
    }
}
