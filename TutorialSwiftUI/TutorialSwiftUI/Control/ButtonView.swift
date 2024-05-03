//
//  ButtonView.swift
//  TutorialSwiftUI
//
//  Created by Song Kim on 5/1/24.
//

import SwiftUI
import CodeEditor

struct ButtonView: View {
    @State private var modArr = [TextModifier]()
    
    var body: some View {
        VStack {
            
            //View Preview
            VStack(alignment: .leading, spacing: 10) {
                TitleTextView(title: "View Preview")
                Text("button")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                HStack{
                    Spacer()
                    // 선택된 수정자를 적용한 텍스트 뷰
                    let modifiedText = Button("Button"){}
                        .apply(modifiers: modArr)
                    modifiedText
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            
            //Button
            MenuButton(modArr: $modArr)
            
            
            let modifiedCode = generateCode(modifiers: modArr, firstCode: "Button(\"Button\"){}")
            
            //CodePreview
            VStack(spacing: 20) {
                TitleTextView(title: "Code Preview")
                CodePreviewView(code: modifiedCode, copyAction: copyCode, showCopy: true)
                    
                TitleTextView(title: "List")
                AddListView(modArr: $modArr)
                    .cornerRadius(10)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)

        }
        .padding()
        .frame(maxHeight: .infinity) // 내부 VStack의 세로 크기를 최대화
        .navigationTitle("Color")
        .navigationBarTitleDisplayMode(.inline)
    }
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
}

#Preview {
    ButtonView()
}
