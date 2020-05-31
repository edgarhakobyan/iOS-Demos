//
//  BillCalculator.swift
//  Calculator Tipsy
//
//  Created by Edgar on 6/1/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

struct BillCalculator {
    var result = "0.0"
    var tip = 0.10
    var split = 2
    
    mutating func setTip(tip: Double) {
        self.tip = tip
    }
    
    mutating func setSplit(split: Int) {
        self.split = split
    }
    
    mutating func calculateBill(bill: String) {
        let billTotal = Double(bill)!
        let resultNumber = billTotal * (1 + tip) / Double(split)
        result = String(format: "%.2f", resultNumber)
    }
}
