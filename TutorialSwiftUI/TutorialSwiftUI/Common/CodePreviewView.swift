//
//  CodePreviewView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 5/4/24.
//

import SwiftUI
import HighlightSwift

struct CodePreviewView: View {
    let highlight = Highlight(cacheLimit: 10)
    let code: String
    let copyAction: (String) -> Void
    let showCopy: Bool
    
    init(code: String, copyAction: @escaping (String) -> Void, showCopy: Bool) {
        self.code = code
        self.copyAction = copyAction
        self.showCopy = showCopy
        UIScrollView.appearance().bounces = false
    }

    @State private var attributedString: AttributedString?
    
    var body: some View {
       
        ZStack {
            ScrollView(.horizontal){
               
                ModifiedTextPreview(attributedString: attributedString)
           
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.5))
            .cornerRadius(10)
            
            
            if showCopy {
                HStack(alignment:.bottom) {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Spacer()
                        Button(action: {
                            copyAction(code)
                        }) {
                            Image(systemName: "doc.on.clipboard.fill")
                                .foregroundColor(.white)
                        }
                        Spacer()
                            .frame(height: 10)
                    }
                    Spacer()
                        .frame(width: 10)
                }
            }
            
        }
        .onAppear {
            Task {
                await codeText()
            }
        }
        .onChange(of: code) { _, _ in
            Task {
                await codeText()
            }
        }
    }
    
    func codeText() async {
        let result = try? await highlight.attributed(code, language: .swift ,colors: HighlightColors.light(.xcode))
        
        attributedString = result
    }
    
}
