//
//  SliderView.swift
//  TutorialSwiftUI
//
//  Created by Song Kim on 5/1/24.
//

import SwiftUI
import CodeEditor

struct SliderView: View {
    @State private var sliderValue = 0.0
    @State private var modArr = [TextModifier]()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // View Preview
                VStack(alignment: .leading, spacing: 10) {
                    TitleTextView(title: "View Preview")
                    Text("Slider")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    HStack {
                        Spacer()
                        Slider(value: $sliderValue, in: -100...100, step: 0.0001)
                            .apply(modifiers: modArr)
                        let formattedValue = String(format: "%.2f", sliderValue)
                        Text(formattedValue)
                            .font(.largeTitle)
                            .padding()
                        Spacer()
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                
                // MenuButton
                MenuButton(modArr: $modArr)
                
                
                // Code Preview
                VStack(spacing: 20) {
                    TitleTextView(title: "Code Preview")
                    let modifiedCode = generateCode(modifiers: modArr, firstCode: """
                        Slider(value: $sliderValue, in: -100...100, step: 1)
                        """
                    )
                    CodePreviewView(code: modifiedCode, copyAction: copyCode, showCopy: true)
                    
                    // List
                    TitleTextView(title: "List")
                    AddListView(modArr: $modArr)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
            .padding()
            .frame(maxHeight: .infinity)
            .navigationTitle("Color")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
}

#Preview {
    SliderView()
}
