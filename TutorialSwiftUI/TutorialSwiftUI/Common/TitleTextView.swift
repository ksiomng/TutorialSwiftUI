//
//  TitleTextView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 5/4/24.
//

import SwiftUI

struct TitleTextView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TitleTextView(title: "TitleText")
}
