//
//  ViewController.swift
//  PageViewExample
//
//  Created by Edgar on 09.01.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startPresentation()
    }
    
    func startPresentation() {
        let userDefaults = UserDefaults.standard
        let isViewed = userDefaults.bool(forKey: "isPresentationViewed")
        if !isViewed {
            if let pageVC = storyboard?.instantiateViewController(identifier: "PageViewController") as? PageViewController {
                present(pageVC, animated: true, completion: nil)
            }
        }
    }

}

