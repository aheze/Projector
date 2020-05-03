//
//  DeviceType.swift
//  Projector
//
//  Created by Zheng on 5/2/20.
//  Copyright © 2020 Zheng. All rights reserved.
//

import UIKit


enum DeviceType {
    
    //MARK: - iPhones
    /**
     iPhone 5, iPhone 5S, iPhone 5C, iPhone SE 1st gen
    */
    case iPhoneSE1
    
    /**
     iPhone 6, iPhone 6S, iPhone 7, iPhone 8, iPhone SE 2nd gen
    */
    case iPhoneSE2
    
    /**
    iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus, iPhone 8 Plus
    */
    case iPhone8Plus
    
    /**
    iPhone X, iPhone XS, iPhone 11 Pro
    */
    case iPhoneX
    
    /**
    iPhone XR, iPhone 11
    */
    case iPhone11
    
    /**
    iPhone XS Max, iPhone 11 Pro Max
    */
    case iPhone11ProMax
    
    
    //MARK: - iPads
    
    /**
    iPad Mini 2nd, 3rd, 4th and 5th Generation
    */
    case iPadMini
    
    /**
    iPad 3rd, iPad 4th, iPad Air 1st, iPad Air 2nd, iPad Pro 9.7-inch, iPad 5th, iPad 6th Generation
    */
    case iPad9_7
    
    /**
    iPad 7th Generation
    */
    case iPad10_2
    
    /**
    iPad Pro 10.5, iPad Air 3rd Generation
    */
    case iPad10_5
    
    /**
    iPad Pro 11-inch 1st and 2nd Generation
    */
    case iPadPro11
    
    /**
    iPad Pro 12.9-inch 1st, 2nd, 3rd and 4th Generation
    */
    case iPadPro12
 
    func getSize() -> CGSize {
        switch self {
        
        case .iPhoneSE1:
            return CGSize(width: 320, height: 568)
        case .iPhoneSE2:
            return CGSize(width: 375, height: 667)
        case .iPhone8Plus:
            return CGSize(width: 414, height: 736)
        case .iPhoneX:
            return CGSize(width: 375, height: 812)
        case .iPhone11:
            return CGSize(width: 414, height: 896)
        case .iPhone11ProMax:
            return CGSize(width: 414, height: 896)
        case .iPadMini:
            return CGSize(width: 768, height: 1024)
        case .iPad9_7:
            return CGSize(width: 768, height: 1024)
        case .iPad10_2:
            return CGSize(width: 810, height: 1080)
        case .iPad10_5:
            return CGSize(width: 834, height: 1112)
        case .iPadPro11:
            return CGSize(width: 834, height: 1194)
        case .iPadPro12:
            return CGSize(width: 1024, height: 1366)
        }
    }
    func getName() -> String {
        switch self {
        case .iPhoneSE1:
            return "iPhone SE"
        case .iPhoneSE2:
            return "iPhone SE2"
        case .iPhone8Plus:
            return "iPhone 8+"
        case .iPhoneX:
            return "iPhone X"
        case .iPhone11:
            return "iPhone 11"
        case .iPhone11ProMax:
            return "iPhone 11 Pro Max"
        case .iPadMini:
            return "iPad Mini"
        case .iPad9_7:
            return "iPad 9.7"
        case .iPad10_2:
            return "iPad 10.2"
        case .iPad10_5:
            return "iPad 10.5"
        case .iPadPro11:
            return "iPad Pro 11"
        case .iPadPro12:
            return "iPad Pro 12"
        }
    }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
extension UIApplication {

    func getKeyWindow() -> UIWindow? {
        if #available(iOS 13, *) {
            return windows.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }

    func makeSnapshot() -> UIImage? { return getKeyWindow()?.layer.makeSnapshot() }
}


extension CALayer {
    func makeSnapshot() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
}

extension UIView {
    func makeSnapshot() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: frame.size)
            return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
        } else {
            return layer.makeSnapshot()
        }
    }
}

extension UIImage {
    convenience init?(snapshotOf view: UIView) {
        guard let image = view.makeSnapshot(), let cgImage = image.cgImage else { return nil }
        self.init(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
}
