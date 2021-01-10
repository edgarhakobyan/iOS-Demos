//
//  PageViewController.swift
//  PageViewExample
//
//  Created by Edgar on 09.01.21.
//

import UIKit

class PageViewController: UIPageViewController {
    
    let presentScreenContent = [
        "You are in the first page",
        "You are in the second page",
        "You are in the third page",
        "You are in the fourth page",
        ""
    ]
    
    let emojiArray = ["😀", "😍", "🤪", "😆", ""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let contentVC = getViewControllerAtIndex(0) {
            setViewControllers([contentVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func getViewControllerAtIndex(_ index: Int) -> ContentViewController? {
        guard index >= 0 else { return nil }
        guard index < presentScreenContent.count else {
            dismiss(animated: true, completion: nil)
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "isPresentationViewed")
            return nil
        }
        
        guard let contentViewController = storyboard?.instantiateViewController(
                identifier: "ContentViewController") as? ContentViewController else { return nil }
        
        contentViewController.prezentText = presentScreenContent[index]
        contentViewController.emojiText = emojiArray[index]
        contentViewController.currentPage = index
        contentViewController.totalPages = presentScreenContent.count
        
        return contentViewController
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let currentVC = viewController as? ContentViewController {
            var pageNumber = currentVC.currentPage
            pageNumber -= 1
            return getViewControllerAtIndex(pageNumber)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let currentVC = viewController as? ContentViewController {
            var pageNumber = currentVC.currentPage
            pageNumber += 1
            return getViewControllerAtIndex(pageNumber)
        }
        return nil
    }
    
    
}
