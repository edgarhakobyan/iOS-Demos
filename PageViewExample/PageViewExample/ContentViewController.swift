//
//  ContentViewController.swift
//  PageViewExample
//
//  Created by Edgar on 09.01.21.
//

import UIKit

class ContentViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var prezentText = ""
    var emojiText = ""
    var currentPage = 0
    var totalPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = prezentText
        emoji.text = emojiText
        pageControl.numberOfPages = totalPages
        pageControl.currentPage = currentPage
    }
}
