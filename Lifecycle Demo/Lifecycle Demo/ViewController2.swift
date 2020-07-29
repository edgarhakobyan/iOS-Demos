//
//  ViewController2.swift
//  Lifecycle Demo
//
//  Created by Edgar on 7/30/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VC2 viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC2 viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VC2 viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("VC2 viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("VC2 viewDidDisappear")
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
