//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Grant Barnes on 3/1/16.
//  Copyright © 2016 Grant Barnes. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet weak var faceView: FaceView! {
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }

    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 1
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int( translation.y / Constants.HappinessGestureScale )
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
            
        }
        
    }
    
    
    var happiness: Int = 100 { // 0= very sad, 100= ecstatic
        didSet{
            happiness = min(max(happiness,0),100)
            updateUI()
        }
    }

    func updateUI(){
        faceView?.setNeedsDisplay()
        title = "\(happiness)"
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
}
