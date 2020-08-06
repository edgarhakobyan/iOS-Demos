//
//  DetailView.swift
//  NewsSwiftUI
//
//  Created by Edgar on 8/7/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import SwiftUI
import WebKit

struct DetailView: View {
    let url: String?
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com")
    }
}
