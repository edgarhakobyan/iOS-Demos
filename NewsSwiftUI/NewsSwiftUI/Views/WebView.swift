//
//  WebView.swift
//  NewsSwiftUI
//
//  Created by Edgar on 8/7/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeUrlString = urlString {
            if let url = URL(string: safeUrlString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
