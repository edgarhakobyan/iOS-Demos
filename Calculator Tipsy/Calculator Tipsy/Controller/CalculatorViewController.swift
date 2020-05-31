//
//  ViewController.swift
//  Calculator Tipsy
//
//  Created by Edgar on 5/31/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!

    var bill = BillCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tipAction(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let buttonTitlePercent = String(buttonTitle.dropLast())
        let buttonTitleNumber = Double(buttonTitlePercent)!
        bill.setTip(tip: buttonTitleNumber / 100)
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        let stepperValue = sender.value
        splitNumberLabel.text = String(format: "%.0f", stepperValue)
        bill.setSplit(split: Int(stepperValue))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billText = billTextField.text!
        if billText != "" {
            bill.calculateBill(bill: billText)
        }
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.result = bill.result
            destinationVC.tip = Int(bill.tip * 100)
            destinationVC.split = bill.split
        }
    }

}

