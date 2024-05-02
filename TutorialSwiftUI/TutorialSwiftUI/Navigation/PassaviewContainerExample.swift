//
//  PassaviewContainerExample.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/2/24.
//

import SwiftUI

struct PassaviewContainerExample: View {
    var body: some View {
        VStack {
            Spacer()
            Text("첫 번째 View 구조체 상단")
            Divider()
                .frame(height: 1)
                .background(Color.red)
            Spacer()
            TemplateView(subView: SomeSubview())
            Spacer()
            Divider()
                .frame(height: 1)
                .background(Color.red)
            Text("첫 번째 View 구조체 하단")
            Spacer()
        }
        .padding(.vertical)
    }
}

struct SomeSubview: View {
    var body: some View {
        Spacer()
        Divider()
            .frame(height: 1)
            .background(Color.green)
        Text("두 번째 View 구조체에서 파라미터로 받은 3번째 View")
            .padding(.vertical)
        Divider()
            .frame(height: 1)
            .background(Color.green)
        Spacer()
    }
}

struct TemplateView<Content: View>: View {
    let subView: Content
    
    var body: some View {
        VStack {
            Spacer()
            Text("첫 번째 View 구조체에서 파라미터로 받은")
            Text("두 번째 View 상단")
            Divider()
                .frame(height: 1)
                .background(Color.blue)
            subView
            Divider()
                .frame(height: 1)
                .background(Color.blue)
            Text("첫 번째 View 구조체에서 파라미터로 받은")
            Text("두 번째 View 하단")
            Spacer()
        }
    }
}

#Preview {
    PassaviewContainerExample()
}
