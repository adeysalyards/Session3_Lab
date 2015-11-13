//
//  CanvasViewController.swift
//  Session3_Lecture_v2
//
//  Created by Salyards, Adey on 11/12/15.
//  Copyright © 2015 Salyards, Adey. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 150
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
        // Do any additional setup after loading the view.
    }

    @IBAction func didPanTray(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            self.trayOriginalCenter = trayView.center
        }else if sender.state == UIGestureRecognizerState.Changed {
            self.trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }else if sender.state == UIGestureRecognizerState.Ended {
            let velocity = sender.velocityInView(view)
            print("\(velocity)")
            if velocity.y >= 0 {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                        self.trayView.center = self.trayDown
                    }, completion: { (Bool) -> Void in
                        
                })
            }else {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                    self.trayView.center = self.trayUp
                    }, completion: { (Bool) -> Void in
                })
            }
        }
    }
    
    @IBAction func didPanFace(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            let imageView = sender.view as! UIImageView
            
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.center = imageView.center
            
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1.5, 1.5)
                }, completion: { (Bool) -> Void in
            })
            
        }else if sender.state == UIGestureRecognizerState.Changed {
            self.newlyCreatedFace.center = CGPoint(x: self.newlyCreatedFaceOriginalCenter.x + translation.x, y: self.newlyCreatedFaceOriginalCenter.y + translation.y)
        }else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: { (Bool) -> Void in
                    UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                        self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)},
                        completion: { (Bool) -> Void in
                        })
            })
        }
    }
    
    
    @IBAction func didPinchNewFace(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        
        newlyCreatedFace = sender.view as! UIImageView
        
        //newlyCreatedFace = UIImageView(image: imageView.image)
        
        newlyCreatedFace.transform = CGAffineTransformMakeScale(scale, scale)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
