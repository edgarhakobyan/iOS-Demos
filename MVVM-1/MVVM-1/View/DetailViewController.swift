//
//  DetailViewController.swift
//  MVVM-1
//
//  Created by Edgar on 30.01.21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailLabel: UILabel!
    
    var viewModel: DetailViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.age.bind(listener: { (str) in
            self.detailLabel.text = str
        })
        
        delay(delay: 5) { [unowned self] in
            self.viewModel?.age.value = "some description"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        detailLabel.text = viewModel?.description
    }
    
    private func delay(delay: Double, closure: @escaping () -> () ) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + delay) {
            closure()
        }
    }

}
