//
//  Utilities.swift
//  Projector
//
//  Created by Zheng on 5/2/20.
//  Copyright © 2020 Zheng. All rights reserved.
//

import UIKit


class PassView: UIView {}
class OverlayControlsWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let hitView = super.hitTest(point, with: event) {
            if hitView.isKind(of: PassView.self) {
                return nil
            }
            return hitView
        }
        return nil
    }
}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}


