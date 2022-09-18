//
//  AlertButton.swift
//  CustomAlert
//
//  Created by Edgar on 16.09.22.
//

import UIKit

@IBDesignable
class AlertButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 22
    }
}
