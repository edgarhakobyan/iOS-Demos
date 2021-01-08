//
//  WebViewController.swift
//  UIKitExamples
//
//  Created by Edgar on 07.01.21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        webView.navigationDelegate = self
        
        let address = "https://www.apple.com"
        
        let url = URL(string: address)
        let request = URLRequest(url: url!)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
        textField.text = address

    }

    @IBAction func backButtonClicked(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonClicked(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}

extension WebViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let address = textField.text!
        let url = URL(string: address)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        textField.text = webView.url?.absoluteString
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
