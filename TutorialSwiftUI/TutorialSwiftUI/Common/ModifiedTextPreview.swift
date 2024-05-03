//
//  ModifiedTextPreview.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 5/4/24.
//

import SwiftUI

struct ModifiedTextPreview: View {
    var attributedString: AttributedString?
    
    var body: some View {
        Group {
            if let attributedString = attributedString {
                Text(attributedString)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.clear)
            } else {
                ProgressView() // 혹은 다른 로딩 인디케이터
            }
        }
    }
}

#Preview {
    ModifiedTextPreview(attributedString: AttributedString("Attr"))
}
