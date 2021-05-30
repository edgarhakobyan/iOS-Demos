//
//  Extentions.swift
//  Networking
//
//  Created by Edgar on 02.05.21.
//

import UIKit

extension UIView {
    func addVerticalGradientLayer(topColor:UIColor, bottomColor:UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIColor {
    convenience init? (hexValue: String, alpha: CGFloat) {
        if hexValue.hasPrefix("#") {
            let scanner = Scanner(string: hexValue)
            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
            var hexInt64: UInt64 = 0
            if hexValue.count == 7 {
                if scanner.scanHexInt64(&hexInt64) {
                    let red = CGFloat((hexInt64 & 0xFF0000) >> 16) / 255
                    let green = CGFloat((hexInt64 & 0x00FF00) >> 8) / 255
                    let blue = CGFloat(hexInt64 & 0x0000FF) / 255
                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }
        return nil
    }
    
    static var primaryColor: UIColor {
        return UIColor(red: 210/255, green: 109/255, blue: 128/255, alpha: 1)
    }
    
    static var secondaryColor: UIColor {
        return UIColor(red: 107/255, green: 148/255, blue: 230/255, alpha: 1)
    }
}
