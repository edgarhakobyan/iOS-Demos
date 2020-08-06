//
//  DiceView.swift
//  DiceeSwiftUI
//
//  Created by Edgar on 8/6/20.
//  Copyright © 2020 Edgar. All rights reserved.
//

import SwiftUI

struct DiceView: View {
    let n: Int
    var body: some View {
        Image("dice\(n)")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding()
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(n: 1)
            .previewLayout(.sizeThatFits)
    }
}
