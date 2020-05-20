//
//  ViewController.swift
//  Dice Game
//
//  Created by Edgar on 5/19/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!

    let diceArray = [ #imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix") ]

    override func viewDidLoad() {
        super.viewDidLoad()

        diceImageView1.image = #imageLiteral(resourceName: "DiceTwo")
        diceImageView2.image = #imageLiteral(resourceName: "DiceSix")
    }

    @IBAction func rollButtonClicked(_ sender: UIButton) {
        diceImageView1.image = diceArray.randomElement()
        diceImageView2.image = diceArray.randomElement()
    }

}

