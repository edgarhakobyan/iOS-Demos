//
//  ResultViewController.swift
//  Calculator
//
//  Created by Edgar on 5/31/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    var bmiValue: String?
    var adviceValue: String?
    var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiLabel.text = bmiValue
        adviceLabel.text = adviceValue
        view.backgroundColor = color
    }
    
    @IBAction func recalculateClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
