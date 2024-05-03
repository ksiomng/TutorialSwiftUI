//
//  MenuVIew.swift
//  TutorialSwiftUI
//
//  Created by Song Kim on 5/1/24.
//

import SwiftUI
import CodeEditor

struct MenuView: View {
    @State private var modArr = [TextModifier]()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // View Preview
                VStack(alignment: .leading, spacing: 10) {
                    TitleTextView(title: "View Preview")
                    Text("button")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    HStack {
                        Spacer()
                        Menu("Menu") {
                            Button("Button1") {}
                            Button("Button2") {}
                        }
                        .apply(modifiers: modArr)
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
                
                
                // Code Preview & List
                VStack(spacing: 20) {
                    TitleTextView(title: "Code Preview")
                    let modifiedCode = generateCode(modifiers: modArr, firstCode: """
                        Menu(\"Menu\"){
                            Button(\"Button1\"){}
                            Button(\"Button2\"){}
                        }
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
            .navigationTitle("Color")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
}


#Preview {
    MenuView()
}
