//
//  ScreenBounds.swift
//  Projector
//
//  Created by Zheng on 5/2/20.
//  Copyright © 2020 Zheng. All rights reserved.
//

import UIKit

var screenBounds: CGRect {
    get {
        if projectorActivated {
            if Thread.current.isMainThread {
                if #available(iOS 13.0, *) {
                    if let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation {
                        if orientation.isPortrait {
                            return CGRect(x: 0, y: 0, width: ProjectorConfiguration.projectedScreenPortraitSize.width, height: ProjectorConfiguration.projectedScreenPortraitSize.height)
                        } else {
                            return CGRect(x: 0, y: 0, width: ProjectorConfiguration.projectedScreenPortraitSize.height, height: ProjectorConfiguration.projectedScreenPortraitSize.width)
                        }
                    } else {
                        return CGRect(x: 0, y: 0, width: ProjectorConfiguration.projectedScreenPortraitSize.width, height: ProjectorConfiguration.projectedScreenPortraitSize.height)
                    }
                } else {
                    
                    let orientation = UIApplication.shared.statusBarOrientation
                    if orientation.isPortrait {
                        return CGRect(x: 0, y: 0, width: ProjectorConfiguration.projectedScreenPortraitSize.width, height: ProjectorConfiguration.projectedScreenPortraitSize.height)
                    } else {
                        return CGRect(x: 0, y: 0, width: ProjectorConfiguration.projectedScreenPortraitSize.height, height: ProjectorConfiguration.projectedScreenPortraitSize.width)
                    }
                    
                }
            } else {
                return DispatchQueue.main.sync {
                    if #available(iOS 13.0, *) {
                        if let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation {
                            if orientation.isPortrait {
                                return CGRect(x: 0, y: 0, width: ProjectorConfiguration.projectedScreenPortraitSize.width, height: ProjectorConfiguration.projectedScreenPortraitSize.height)
                            } else {
                                return CGRect(x: 0, y: 0, width: ProjectorConfiguration.projectedScreenPortraitSize.height, height: ProjectorConfiguration.projectedScreenPortraitSize.width)
                            }
                        } else {
                            return CGRect(x: 0, y: 0, width: ProjectorConfiguration.projectedScreenPortraitSize.width, height: ProjectorConfiguration.projectedScreenPortraitSize.height)
                        }
                        
                    } else {
                        let orientation = UIApplication.shared.statusBarOrientation
                        
                        if orientation.isPortrait {
                            return CGRect(x: 0, y: 0, width: ProjectorConfiguration.projectedScreenPortraitSize.width, height: ProjectorConfiguration.projectedScreenPortraitSize.height)
                        } else {
                            return CGRect(x: 0, y: 0, width: ProjectorConfiguration.projectedScreenPortraitSize.height, height: ProjectorConfiguration.projectedScreenPortraitSize.width)
                        }
                    }
                }
            }
        } else {
            return UIScreen.main.bounds
        }
    }
}
