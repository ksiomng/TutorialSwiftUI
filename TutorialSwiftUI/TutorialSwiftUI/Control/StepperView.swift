//
//  StepperView.swift
//  TutorialSwiftUI
//
//  Created by Song Kim on 5/1/24.
//

import SwiftUI
import CodeEditor

struct StepperView: View {
    @State private var sleepAmount = 0.0
    @State private var modArr = [TextModifier]()
    
    var body: some View {
        ScrollView {
            VStack {
                
                //View Preview
                VStack(alignment: .leading, spacing: 10) {
                    TitleTextView(title: "View Preview")
                    Text("Stepper")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    HStack{
                        Spacer()
                        Stepper(value: $sleepAmount) {
                            Text("\(sleepAmount)")
                        }
                        .apply(modifiers: modArr)
                        .padding()
                        .frame(minHeight: 100)
                        .font(.largeTitle)
                        Spacer()
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                
                //Button
                MenuButton(modArr: $modArr)
                
                
                //CodePreview & List
                VStack(spacing: 20) {
                    TitleTextView(title: "Code Preview")
                    let modifiedCode = generateCode(modifiers: modArr, firstCode: """
                        Stepper(value: $amount){
                            Text(\"amount\")
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
    StepperView()
}
