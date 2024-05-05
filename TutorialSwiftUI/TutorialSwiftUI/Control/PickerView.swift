//
//  PickerView.swift
//  TutorialSwiftUI
//
//  Created by Song Kim on 5/1/24.
//

import SwiftUI
import CodeEditor

struct PickerView: View {
    var colors = ["red", "green", "blue"]
    @State var selectedColor = ""
    @State private var modArr = [TextModifier]()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // View Preview
                VStack(alignment: .leading, spacing: 10) {
                    TitleTextView(title: "View Preview")
                    Text("Picker")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    HStack {
                        Spacer()
                        Picker("", selection: $selectedColor) {
                            ForEach(colors, id: \.self) {
                                Text($0)
                            }
                        }
                        .apply(modifiers: modArr)
                        .pickerStyle(.wheel)
                        .font(.largeTitle)
                        .padding()
                        Spacer()
                    }
                    .frame(maxHeight: 130)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                
                // MenuButton
                MenuButton(modArr: $modArr)
                
                
                // Code Preview & List
                VStack(spacing: 20) {
                    TitleTextView(title: "Code Preview")
                    let modifiedCode = generateCode(modifiers: modArr, firstCode: """
                        var colors = [\"red\", \"green\", \"blue\"]
                        @State var selectedColor = \"\"
                            
                        Picker(\"\", selection: $selectedColor) {
                            ForEach(colors, id: \\.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                        """)
                    CodePreviewView(code: modifiedCode, copyAction: copyCode, showCopy: true)

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
            .navigationTitle("Picker")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
}

#Preview {
    PickerView()
}
