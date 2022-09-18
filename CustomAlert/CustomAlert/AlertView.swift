//
//  AlertView.swift
//  CustomAlert
//
//  Created by Edgar on 16.09.22.
//

import UIKit

protocol AlertDelegate {
    func leftButtonTapped()
    func rightButtonTapped()
}

class AlertView: UIView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var leftButton: AlertButton!
    @IBOutlet weak var rightButton: AlertButton!
    
    var delegate: AlertDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(title: String, body: String, leftButtonTitle: String, rightButtonTitle: String) {
        self.title.text = title
        self.body.text = body
        self.leftButton.setTitle(leftButtonTitle, for: .normal)
        self.rightButton.setTitle(rightButtonTitle, for: .normal)
    }
    
    @IBAction func leftButtonTapped(_ sender: AlertButton) {
        delegate?.leftButtonTapped()
    }
    
    @IBAction func rightButtonTapped(_ sender: AlertButton) {
        delegate?.rightButtonTapped()
    }
    
    deinit {
        print("Alert deinit")
    }

}
