//
//  ViewController.swift
//  AutoReleasePoolExample
//
//  Created by Edgar on 12.08.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    let queue = DispatchQueue(label: "test")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        overrideUserInterfaceStyle = .light
        
        loadImages()
    }


    func loadImages() {
        let url = URL(string: "https://picsum.photos/200")!
        
        for _ in 0...500 {
            queue.async { [unowned self] in
                autoreleasepool {
                    guard let data = try? Data(contentsOf: url),
                          let image = UIImage(data: data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
}

