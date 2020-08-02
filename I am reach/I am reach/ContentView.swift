//
//  ContentView.swift
//  I am reach
//
//  Created by Edgar on 8/3/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.green)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("I Am Reach!")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Image("diamond")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: 200.0, alignment: .center)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
