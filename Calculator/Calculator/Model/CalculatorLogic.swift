//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Edgar on 8/23/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    private var number: Double?
    private var intermediate: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    private func performCalculation(n2: Double) -> Double? {
        if let n1 = intermediate?.n1,
            let method = intermediate?.calcMethod {
            switch method {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "*":
                return n1 * n2
            case "/":
                return n1 / n2
            default:
                fatalError("Unexpected operation!!!")
            }
        }
        return nil
    }
    
    mutating func calculate(symbol: String) -> Double? {
        if let n = number {
            switch symbol {
            case "+/-":
                return n * -1
            case "AC":
                return 0
            case "%":
                return n / 100
            case "=":
                return performCalculation(n2: n)
            default:
                intermediate = (n1: n, calcMethod: symbol)
            }
        }
        return nil
    }
}
