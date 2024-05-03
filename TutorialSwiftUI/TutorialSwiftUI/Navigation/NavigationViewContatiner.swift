//
//  NavigationContainerView.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/1/24.
//

import SwiftUI
import CodeEditor

struct NavigationViewContatiner: View {
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
            
            Text("NavigationView")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            VStack{
                Spacer()
                
                BulletPointText(text: "SwiftUI의 기본적인 컨테이너 뷰로, 계층적 네비게이션 인터페이스를 구성할 때 사용.")
                BulletPointText(text: "이 뷰 안에 다른 뷰들이 들어가며, 사용자가 다른 화면으로 이동할 수 있는 경로를 제공.")
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
                    NavigationView{
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
    NavigationViewContatiner()
}
