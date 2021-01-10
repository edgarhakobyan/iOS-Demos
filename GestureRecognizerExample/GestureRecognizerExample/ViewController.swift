//
//  ViewController.swift
//  GestureRecognizerExample
//
//  Created by Edgar on 10.01.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeObservers()
        tapObserver()
    }
    
    func swipeObservers() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func tapObserver() {
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap))
        tripleTap.numberOfTapsRequired = 3
        self.view.addGestureRecognizer(tripleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.require(toFail: tripleTap)
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
    }

    @objc func handleSwipes(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            label.text = "Swipe right was handled"
        case .left:
            label.text = "Swipe left was handled"
        case .up:
            label.text = "Swipe up was handled"
        case .down:
            label.text = "Swipe down was handled"
        default:
            break
        }
    }
    
    @objc func handleTripleTap() {
        label.text = "Triple tap was handled"
    }
    
    @objc func handleDoubleTap() {
        label.text = "Double tap was handled"
    }

}

