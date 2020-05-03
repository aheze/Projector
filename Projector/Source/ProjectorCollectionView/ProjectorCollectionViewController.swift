//
//  ProjectorCollectionViewController.swift
//  Projector
//
//  Created by Zheng on 5/2/20.
//  Copyright © 2020 Zheng. All rights reserved.
//

import UIKit


class ProjectorCollectionViewController: UIViewController {
    
    weak var collectionView: UICollectionView!
    weak var selectedIconView: UIView!
    weak var collectionViewReferenceView: UIView!
    
    weak var controlsView: UIView!
    
    weak var aztecCodeView: UIView!
    weak var astecCodeImageView: UIImageView!
    
    weak var leftButton: UIButton!
    weak var middleButton: UIButton!
    weak var rightButton: UIButton!
    
    weak var menuButton: UIButton!
    var isShowingMenu = true
    var enablePressMenu = true
    
    var leftConstraint = NSLayoutConstraint()
    var bottomContraint = NSLayoutConstraint()
    
    var leftMidConstraint = NSLayoutConstraint()
    var bottomMidConstraint = NSLayoutConstraint()
    
    var widthConstraint = NSLayoutConstraint()
    var heightConstraint = NSLayoutConstraint()
    
    var originalSize = CGSize()
    var originalWidth = CGFloat()
    var originalHeight = CGFloat()

    func disableMenuPress() {
        enablePressMenu = false
        disableMenu()
    }
    
    func enableMenuPress() {
        enablePressMenu = true
        enableMenu()
    }
    
    func disableMenu() {
//        print("DIDIDSS")
        isShowingMenu = false
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .semibold)
        let menuImage = UIImage(systemName: "slider.horizontal.3", withConfiguration: symbolConfiguration)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        self.menuButton.setImage(menuImage, for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.controlsView.frame = CGRect(x: 50, y: 0, width: 40, height: 40)
            
            self.leftButton.alpha = 0
            self.middleButton.alpha = 0
            self.rightButton.alpha = 0
            
            self.collectionView.alpha = 0
            self.selectedIconView.alpha = 0
        })
    }
    func enableMenu() {
//        print("SNSNSNSNenenene")
        isShowingMenu = true
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .semibold)
        let menuImage = UIImage(systemName: "xmark", withConfiguration: symbolConfiguration)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        self.menuButton.setImage(menuImage, for: .normal)
        
//        self.collectionView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.controlsView.frame = CGRect(x: 50, y: 0, width: 150, height: 40)
            
            self.collectionView.alpha = 1
            self.selectedIconView.alpha = 1
            self.leftButton.alpha = 0.4
            self.middleButton.alpha = 0.4
            self.rightButton.alpha = 0.4
            
            switch ProjectorConfiguration.settings.position {
            case .centered:
                self.middleButton.alpha = 1
            case .left:
                self.leftButton.alpha = 1
            case .right:
                self.rightButton.alpha = 1
            case .top:
                self.leftButton.alpha = 1
            case .bottom:
                self.rightButton.alpha = 1
            }
        })
    }
    @objc func menuPressed(sender: UIButton!) {
        if enablePressMenu {
            if isShowingMenu {
                disableMenu()
            } else {
                enableMenu()
            }
        } else {
            let alert = UIAlertController(title: "Rotate your device!", message: "Changing the Projector configuration is only allowed in portrait view", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @objc func leftPressed(sender: UIButton!) {
        
        let currentSize = ProjectorConfiguration.simulatedDevice.getSize()
        let currentAspectRatio = currentSize.width / currentSize.height
        let originalAspectRatio = originalWidth / originalHeight
        
        if originalAspectRatio < currentAspectRatio {
            ProjectorConfiguration.settings.position = .top
        } else if originalAspectRatio > currentAspectRatio {
            ProjectorConfiguration.settings.position = .left
        }
        
        leftButton.alpha = 1
        middleButton.alpha = 0.6
        rightButton.alpha = 0.6
        animateCollectionviewChange(newDevice: ProjectorConfiguration.simulatedDevice)
    }
    @objc func centerPressed(sender: UIButton!) {
        ProjectorConfiguration.settings.position = .centered
        leftButton.alpha = 0.6
        middleButton.alpha = 1
        rightButton.alpha = 0.6
        animateCollectionviewChange(newDevice: ProjectorConfiguration.simulatedDevice)
    }
    @objc func rightPressed(sender: UIButton!) {
        let currentSize = ProjectorConfiguration.simulatedDevice.getSize()
        let currentAspectRatio = currentSize.width / currentSize.height
        let originalAspectRatio = originalWidth / originalHeight
        
        if originalAspectRatio < currentAspectRatio {
            ProjectorConfiguration.settings.position = .bottom
        } else if originalAspectRatio > currentAspectRatio {
            ProjectorConfiguration.settings.position = .right
        }
        
        leftButton.alpha = 0.6
        middleButton.alpha = 0.6
        rightButton.alpha = 1
        animateCollectionviewChange(newDevice: ProjectorConfiguration.simulatedDevice)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view = PassView()
        
        ProjectorConfiguration.collectionController = self
        
        
        originalSize = ProjectorConfiguration.originalSize
        originalWidth = originalSize.width
        originalHeight = originalSize.height
        
        let originalAspectRatio = originalWidth / originalHeight
        
        let newSize = ProjectorConfiguration.simulatedDevice.getSize()
        let newAspectRatio = newSize.width / newSize.height
        
        let iconView = UIView()
        
        let referenceView = UIView(frame: .zero)
        referenceView.backgroundColor = UIColor.clear
        referenceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(referenceView)
        
        iconView.backgroundColor = UIColor.gray
        iconView.layer.cornerRadius = 10
        referenceView.addSubview(iconView)
        self.selectedIconView = iconView
        
        self.selectedIconView.alpha = 0
        
        var collectionTransform = CGAffineTransform()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        referenceView.addSubview(collectionView)
        self.collectionView = collectionView
        self.collectionViewReferenceView = referenceView
        
//        self.collectionView.isHidden = true
        self.collectionView.alpha = 0
        
        let overlayControls = UIView()
        overlayControls.frame = CGRect(x: 50, y: 0, width: 40, height: 40)
        overlayControls.layer.cornerRadius = 6
        overlayControls.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        overlayControls.backgroundColor = #colorLiteral(red: 0.4158049939, green: 0.4158049939, blue: 0.4158049939, alpha: 1)
        referenceView.addSubview(overlayControls)
        self.controlsView = overlayControls
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .semibold)
        
        let menu = UIButton()
        overlayControls.addSubview(menu)
        menu.frame = CGRect(x: 0, y: 2, width: 36, height: 36)
        let menuImage = UIImage(systemName: "slider.horizontal.3", withConfiguration: symbolConfiguration)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        menu.setImage(menuImage, for: .normal)
        menu.imageView?.contentMode = .scaleAspectFit
        menu.addTarget(self, action: #selector(menuPressed), for: .touchUpInside)
        self.menuButton = menu
        
        let leftButton = UIButton()
        overlayControls.addSubview(leftButton)
        leftButton.frame = CGRect(x: 48, y: 2, width: 36, height: 36)
        
        let leftImage = UIImage(systemName: "chevron.up", withConfiguration: symbolConfiguration)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        leftButton.setImage(leftImage, for: .normal)
        leftButton.imageView?.contentMode = .scaleAspectFit
        leftButton.addTarget(self, action: #selector(leftPressed), for: .touchUpInside)
        self.leftButton = leftButton
        
        let middleButton = UIButton()
        overlayControls.addSubview(middleButton)
        middleButton.frame = CGRect(x: 87, y: 10, width: 20, height: 20)
        
        let middleImage = UIImage(systemName: "circle.fill", withConfiguration: symbolConfiguration)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        middleButton.setImage(middleImage, for: .normal)
        middleButton.imageView?.contentMode = .scaleAspectFit
        middleButton.addTarget(self, action: #selector(centerPressed), for: .touchUpInside)
        self.middleButton = middleButton
        
        let rightButton = UIButton()
        overlayControls.addSubview(rightButton)
        rightButton.frame = CGRect(x: 108, y: 2, width: 36, height: 36)
        
        let rightImage = UIImage(systemName: "chevron.down", withConfiguration: symbolConfiguration)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        rightButton.setImage(rightImage, for: .normal)
        rightButton.imageView?.contentMode = .scaleAspectFit
        rightButton.addTarget(self, action: #selector(rightPressed), for: .touchUpInside)
        self.rightButton = rightButton
        
        leftButton.alpha = 0
        middleButton.alpha = 0
        rightButton.alpha = 0
        
        let codeOverlayView = UIView()
        codeOverlayView.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        codeOverlayView.backgroundColor = UIColor.white
        
        self.aztecCodeView = codeOverlayView
        referenceView.addSubview(codeOverlayView)
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 12, y: 2, width: 36, height: 36)
        
        self.astecCodeImageView = imageView
        codeOverlayView.addSubview(imageView)
        
        
        var horizontalOffset = CGFloat(0)
        var verticalOffset = CGFloat(0)
        
        var isSideways = true
        
        switch ProjectorConfiguration.settings.position {
        case .centered:
        if originalAspectRatio < newAspectRatio {
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(0))
            isSideways = false
        } else if originalAspectRatio > newAspectRatio {
            isSideways = true
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(-90).degreesToRadians)
        }
            
        case .left:
            isSideways = true
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(-90).degreesToRadians)
            horizontalOffset = originalWidth - 40
        case .right:
            isSideways = true
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(-90).degreesToRadians)
        case .top:
            isSideways = false
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(0))
        case .bottom:
            isSideways = false
            verticalOffset = -(originalHeight - 40)
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(0))
        }
        
        let deviceName = ProjectorConfiguration.simulatedDevice.getName()

        let nameWidth = width(text: deviceName, height: 40)
        let halfNameWidth = nameWidth / 2
        
        var statusOffset = CGFloat(0)
        if ProjectorConfiguration.settings.shouldStopAtStatusBar {
            statusOffset = ProjectorConfiguration.statusBarHeight
        }
        
        if isSideways {
            iconView.frame = CGRect(x: (originalHeight / 2) - halfNameWidth - 8, y: 0, width: nameWidth + 16, height: 40)
            
            leftMidConstraint = referenceView.centerXAnchor.constraint(equalTo: self.view.leadingAnchor, constant: horizontalOffset)
            bottomMidConstraint = referenceView.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: verticalOffset)
            widthConstraint = referenceView.widthAnchor.constraint(equalToConstant: originalHeight)
            heightConstraint = referenceView.heightAnchor.constraint(equalToConstant: 40)
            
            
            leftConstraint = collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: horizontalOffset)
            bottomContraint = collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: verticalOffset)
            
            
            leftMidConstraint.isActive = true
            bottomMidConstraint.isActive = true
            leftConstraint.isActive = false
            bottomContraint.isActive = false
            widthConstraint.isActive = true
            heightConstraint.isActive = true
            
            collectionView.contentInset = UIEdgeInsets(top: 0, left: (originalHeight / 2), bottom: 0, right: (originalHeight / 2))
            referenceView.setAnchorPoint(CGPoint(x: 0, y: 0))
            referenceView.transform = collectionTransform
        } else {
            selectedIconView.frame = CGRect(x: statusOffset + (originalWidth / 2) - halfNameWidth - 8, y: UIScreen.main.bounds.size.height - verticalOffset, width: nameWidth + 16, height: 40)
            leftConstraint = collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: horizontalOffset)
            bottomContraint = collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: verticalOffset)
            
            widthConstraint = collectionView.widthAnchor.constraint(equalToConstant: originalWidth)
            heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 40)
            
            leftMidConstraint = referenceView.centerXAnchor.constraint(equalTo: self.view.leadingAnchor, constant: horizontalOffset)
            bottomMidConstraint = referenceView.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: verticalOffset)
            
            
            collectionView.contentInset = UIEdgeInsets(top: 0, left: (originalWidth / 2), bottom: 0, right: (originalWidth / 2))
            referenceView.setAnchorPoint(CGPoint(x: 0.5, y: 0.5))
            referenceView.transform = collectionTransform
            
            leftMidConstraint.isActive = false
            bottomMidConstraint.isActive = false
            leftConstraint.isActive = true
            bottomContraint.isActive = true
            widthConstraint.isActive = true
            heightConstraint.isActive = true
        }
        
        NSLayoutConstraint.activate([
            referenceView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            referenceView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            referenceView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            referenceView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        self.collectionView.backgroundColor = .white
        
        if let indexItem = ProjectorConfiguration.devices.firstIndex(of: ProjectorConfiguration.simulatedDevice) {
            let indP = IndexPath(item: indexItem, section: 0)
            collectionView.layoutIfNeeded()
            collectionView.scrollToItem(at: indP, at: .centeredHorizontally, animated: false)
        }
        
        
        self.collectionView.backgroundColor = UIColor.clear
        ProjectorConfiguration.initializedCollectionController = true
    }
    
}


extension ProjectorCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return ProjectorConfiguration.devices.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
        let device = ProjectorConfiguration.devices[indexPath.item]
        cell.textLabel.text = device.getName()
        return cell
    }
}
extension ProjectorCollectionViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var nearestIndexPath = IndexPath(item: 0, section: 0)
        var nearestDistance = CGFloat(9999)
        let centerPoint = CGPoint(x: collectionView.bounds.width / 2, y: 20)
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            if let attributes = collectionView.layoutAttributesForItem(at: indexPath) {
                let center = attributes.center
                let actual = collectionView.convert(center, to: collectionViewReferenceView)
                let dist = distance(actual, centerPoint)
                if dist <= nearestDistance {
                    nearestDistance = dist
                    nearestIndexPath = indexPath
                }
            }
        }
        selectCellAt(nearestIndexPath)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            var nearestIndexPath = IndexPath(item: 0, section: 0)
            var nearestDistance = CGFloat(9999)
            let centerPoint = CGPoint(x: collectionView.bounds.width / 2, y: 20)
            let indexPaths = collectionView.indexPathsForVisibleItems
            for indexPath in indexPaths {
                if let attributes = collectionView.layoutAttributesForItem(at: indexPath) {
                    let center = attributes.center
                    let actual = collectionView.convert(center, to: collectionViewReferenceView)
                    let dist = distance(actual, centerPoint)
                    if dist <= nearestDistance {
                        nearestDistance = dist
                        nearestIndexPath = indexPath
                    }
                }
            }
            
            selectCellAt(nearestIndexPath)
        }
    }
    
    func selectCellAt(_ indexPath: IndexPath) {
        
        let newDevice = ProjectorConfiguration.devices[indexPath.item]
        
        animateCollectionviewChange(newDevice: newDevice)
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    func animateCollectionviewChange(newDevice: DeviceType) {
        
        
        let currentSimulatedDevice = ProjectorConfiguration.simulatedDevice
        let currentSimulatedSize = currentSimulatedDevice.getSize()
        let currentAspectRatio = currentSimulatedSize.width / currentSimulatedSize.height
        let deviceName = newDevice.getName()
        let nameWidth = width(text: deviceName, height: 40)
        let halfNameWidth = nameWidth / 2
        
        let originalAspectRatio = originalWidth / originalHeight
        
        let newSize = newDevice.getSize()
        let newAspectRatio = newSize.width / newSize.height
        
        
        var isSideways = true
        var originallyWasSideways = false
         
        if originalAspectRatio < currentAspectRatio {
            originallyWasSideways = false
        } else if originalAspectRatio > currentAspectRatio {
            originallyWasSideways = true
        }
        
        
        if originalAspectRatio < newAspectRatio {
            isSideways = false
        } else if originalAspectRatio > newAspectRatio {
            isSideways = true
        }
        
        let originalPosition = ProjectorConfiguration.settings.position
        
        
        if originallyWasSideways != isSideways {
            leftButton.alpha = 0.6
            middleButton.alpha = 0.6
            rightButton.alpha = 0.6
            
            switch originalPosition {
                
            case .centered:
                middleButton.alpha = 1
                ProjectorConfiguration.settings.position = .centered
            case .left:
                leftButton.alpha = 1
                ProjectorConfiguration.settings.position = .top
            case .right:
                rightButton.alpha = 1
                ProjectorConfiguration.settings.position = .bottom
            case .top:
                leftButton.alpha = 1
                ProjectorConfiguration.settings.position = .left
            case .bottom:
                rightButton.alpha = 1
                ProjectorConfiguration.settings.position = .right
            }
        }
//        else {
//            ProjectorConfiguration.settings.position = originalPosition
//            switch originalPosition {
//            case .centered:
//                middleButton.alpha = 1
//            case .left:
//                leftButton.alpha = 1
//            case .right:
//                rightButton.alpha = 1
//            case .top:
//                leftButton.alpha = 1
//            case .bottom:
//                rightButton.alpha = 1
//            }
//        }
        
        var collectionTransform = CGAffineTransform()
        var horizontalOffset = CGFloat(0)
        var verticalOffset = CGFloat(0)
        switch ProjectorConfiguration.settings.position {
        case .centered:
        if originalAspectRatio < newAspectRatio {
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(0))
        } else if originalAspectRatio > newAspectRatio {
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(-90).degreesToRadians)
        }
            
        case .left:
            isSideways = true
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(-90).degreesToRadians)
            horizontalOffset = originalWidth - 40
        case .right:
            isSideways = true
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(-90).degreesToRadians)
           
        case .top:
            isSideways = false
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(0))
        case .bottom:
            isSideways = false
            verticalOffset = -(originalHeight - 40)
            collectionTransform = CGAffineTransform(rotationAngle: CGFloat(0))
        }
        
        var statusOffset = CGFloat(0)
        if ProjectorConfiguration.settings.shouldStopAtStatusBar {
            statusOffset = ProjectorConfiguration.statusBarHeight
        }
        
        var anchorPoint = CGPoint()
        
        var newFrameRect = CGRect()
        
//        print("ISDIEW?? \(isSideways)")
        if isSideways {
            leftMidConstraint.constant = horizontalOffset
            bottomMidConstraint.constant = verticalOffset
            widthConstraint.constant = originalHeight
            heightConstraint.constant = 40
            
            leftMidConstraint.isActive = true
            bottomMidConstraint.isActive = true
            leftConstraint.isActive = false
            bottomContraint.isActive = false
            newFrameRect = CGRect(x: (originalHeight / 2) - halfNameWidth - 8, y: 0, width: nameWidth + 16, height: 40)
            
            collectionView.contentInset = UIEdgeInsets(top: 0, left: (originalHeight / 2), bottom: 0, right: (originalHeight / 2))
            anchorPoint = CGPoint(x: 0, y: 0)
        } else {
            selectedIconView.frame = CGRect(x: statusOffset + (originalWidth / 2) - halfNameWidth - 8, y: UIScreen.main.bounds.size.height - verticalOffset, width: nameWidth + 16, height: 40)
            leftConstraint.constant = horizontalOffset
            bottomContraint.constant = verticalOffset
            widthConstraint.constant = originalWidth
            heightConstraint.constant = 40
            
            
            leftMidConstraint.isActive = false
            bottomMidConstraint.isActive = false
            leftConstraint.isActive = true
            bottomContraint.isActive = true
            
            newFrameRect = CGRect(x: (originalWidth / 2) - halfNameWidth - 8, y: 0, width: nameWidth + 16, height: 40)
            
            collectionView.contentInset = UIEdgeInsets(top: 0, left: (originalWidth / 2), bottom: 0, right: (originalWidth / 2))
            anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionViewReferenceView.layoutIfNeeded()
            self.collectionViewReferenceView.setAnchorPoint(anchorPoint)
            self.collectionViewReferenceView.transform = collectionTransform
            self.selectedIconView.frame = newFrameRect
        })
        
        ProjectorConfiguration.simulatedDevice = newDevice
        Projector.project(device: newDevice)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCellAt(indexPath)
    }
}

extension ProjectorCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var properWidth = CGFloat(50)
        let device = ProjectorConfiguration.devices[indexPath.item]
        let deviceName = device.getName()
        properWidth = width(text: deviceName, height: 40)
        
        return CGSize(width: properWidth + 20, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension ProjectorCollectionViewController {
    func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let xDist = a.x - b.x
        let yDist = a.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
    func width(text: String, height: CGFloat) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17)
        ]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        let constraintBox = CGSize(width: .greatestFiniteMagnitude, height: height)
        let textWidth = attributedText.boundingRect(with: constraintBox, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).width.rounded(.up)

        return textWidth
    }
}
