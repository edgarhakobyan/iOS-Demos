//
//  ContentView.swift
//  MyCard
//
//  Created by Edgar on 8/3/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0, green: 1, blue: 1)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("edgar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                Text("Edgar Hakobyan")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .foregroundColor(Color.white)
                    .bold()
                Text("iOS Developer")
                    .foregroundColor(Color.white)
                    .font(.system(size: 25))
                Divider()
                InfoView(text: "+374 77 12 34 56", imageName: "phone.fill")
                InfoView(text: "edgar@email.com", imageName: "envelope.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
