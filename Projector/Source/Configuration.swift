//
//  Configuration.swift
//  Projector
//
//  Created by Zheng on 5/2/20.
//  Copyright © 2020 Zheng. All rights reserved.
//

import UIKit

var projectorActivated = false

class ProjectorSettings: NSObject {
    
    var shouldStopAtStatusBar = true
    var position = SwapPosition.centered
    var defaultDeviceToProject = DeviceType.iPhoneX
    var shouldShowControls = true
}

class ProjectorConfiguration: NSObject {
    
    static var isLandscape = false
    
    static var rootWindow = UIWindow()
    
    static var collectionWindow = UIWindow()
    static var collectionController = ProjectorCollectionViewController()
    static var initializedCollectionController = false
    
//    static var currentFrameForCropping = CGRect(x: 0, y: 0, width: 500, height: 500)
    static var projectedScreenPortraitSize = CGSize(width: 0, height: 0)
    static var settings = ProjectorSettings()
    static var simulatedDevice = DeviceType.iPhoneX
    static var originalSize = CGSize(width: 0, height: 0)
    static var statusBarHeight = CGFloat(0)
    static var devices: [DeviceType] = [.iPhoneSE1, .iPhoneSE2, .iPhone8Plus, .iPhoneX, .iPhone11, .iPhone11ProMax, .iPadMini, .iPad9_7, .iPad10_2, .iPad10_5, .iPadPro11, .iPadPro12]
    
}
