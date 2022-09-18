//
//  Nib.swift
//  CustomAlert
//
//  Created by Edgar on 17.09.22.
//

import Foundation
import UIKit

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil)![0] as! T
    }
}
