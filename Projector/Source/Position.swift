//
//  Position.swift
//  Projector
//
//  Created by Zheng on 5/2/20.
//  Copyright © 2020 Zheng. All rights reserved.
//

import Foundation


enum SwapPosition {
    
    /**
     This is default (depends on you phone and the phone that you want to simulate).
     
     If the iPhone that you want to simulate is __skinnier__ than yours, it will be centered horizontically, and the gap with the controls will be evenly ditributed on the left and right.
     
     If it's __wider__, it will be centered vertically, and the gap with the controls will be evenly ditributed on the top and bottom.
    */
    case centered
    
    /**
     The simulated screen will stick to the __left__ of your phone, and the gap with the controls will be on the right.
     
     Only works if the iPhone that you want to simulate is __skinnier__ than yours
    */
    case left
    
    /**
     The simulated screen will stick to the __right__  of your phone, and the gap with the controls will be on the left.
     
     Only works if the iPhone that you want to simulate is __skinnier__ than yours
    */
    case right
    
    /**
     The simulated screen will stick to the __top__ of your phone, and the gap with the controls will be on the bottom.
     
     Only works if the iPhone that you want to simulate is __wider__ than yours
    */
    case top
    
    /**
     The simulated screen will stick to the __bottom__ of your phone, and the gap with the controls will be on the top.
     
     Only works if the iPhone that you want to simulate is __wider__ than yours
    */
    case bottom
}
