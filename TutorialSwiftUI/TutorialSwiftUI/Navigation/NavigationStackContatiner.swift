//
//  NavigationStackContainer.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/2/24.
//

import SwiftUI
import CodeEditor

struct NavigationStackContatiner: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                overViewSection
                codePreviewSection
            }
            .padding()
            .frame(maxHeight: .infinity) // 내부 VStack의 세로 크기를 최대화
            .navigationTitle("Color")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    private var overViewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            TitleTextView(title: "Overview")
            
            Text("NavigationStack")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            VStack{
                Spacer()
                
                BulletPointText(text: "사용자가 View 계층을 통해 앞으로 나아갈 수 있게 도와주는 Stack 기반 Navigation.")
                BulletPointText(text: " NavigationStack 안에는 여러 개의 View가 순차적으로 쌓여, 더 깊은 화면으로 이동할 수 있음.")
                    .padding(.horizontal)
                    .padding(.top, 5)
                
                Spacer()
            }
            
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var codePreviewSection: some View {
        VStack(spacing: 20) {
            TitleTextView(title: "Base Code")
            
            CodePreviewView(code: basecode(), copyAction: copyCode, showCopy: true)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    
    // Base code
    func basecode() -> String {
        """
        struct ContentView: View {
                var body: some View {
                    NavigationStack{
                        Text("Hello, World!")
                    }
                }
            }
        """
    }
    
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
    
    /// Bullet point text style
    struct BulletPointText: View {
        var text: String
        
        var body: some View {
            HStack(alignment: .top, spacing: 5) {
                Text("•")
                Text(text)
            }
        }
    }
    
}

#Preview {
    NavigationStackContatiner()
}
