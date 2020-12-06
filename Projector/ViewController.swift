//
//  ViewController.swift
//  Projector
//
//  Created by Zheng on 5/2/20.
//  Copyright © 2020 Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentRotation: CGFloat = 0
    
    @IBOutlet weak var blueView: UIView!
    
    @IBAction func sampleAppPressed(_ sender: Any) {
        if currentRotation == 270 {
            currentRotation = 0
        } else {
            currentRotation += 90
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.blueView.transform = CGAffineTransform(rotationAngle: self.currentRotation.degreesToRadians)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueView.layer.cornerRadius = 16
    }
    
    override var prefersStatusBarHidden: Bool {
         return true
    }
}
