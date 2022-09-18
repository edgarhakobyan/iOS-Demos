//
//  ViewController.swift
//  CustomAlert
//
//  Created by Edgar on 16.09.22.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var alertView: AlertView = {
//        alertView = Bundle.main.loadNibNamed("AlertView", owner: self)?[0] as? AlertView
        let alertView: AlertView = AlertView.loadFromNib()
        alertView.delegate = self
        return alertView
    }()
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVisualEffectView()
    }
    
    private func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    private func setAlert() {
        alertView.set(title: "Hi", body: "test body", leftButtonTitle: "Cancel", rightButtonTitle: "OK")
        view.addSubview(alertView)
        alertView.center = view.center
    }
    
    private func animateIn() {
        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
    }
    
    private func animateOut() {
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 0
            self.alertView.alpha = 0
            self.alertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } completion: { (_) in
            self.alertView.removeFromSuperview()
        }

    }
    
    @IBAction func alertButtonAction(_ sender: UIButton) {
        setAlert()
        animateIn()
    }
    
}

extension ViewController: AlertDelegate {
    func leftButtonTapped() {
        print("leftButtonTapped")
        animateOut()
    }
    
    func rightButtonTapped() {
        print("rightButtonTapped")
        animateOut()
    }
}
