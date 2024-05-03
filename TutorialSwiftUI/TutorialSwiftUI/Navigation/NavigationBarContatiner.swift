//
//  NavigationBarView.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/2/24.
//

import SwiftUI
import CodeEditor

struct NavigationBarContatiner: View {
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                viewPreviewSection
                codePreviewSection
            }
            .padding()
            .frame(maxHeight: .infinity)
            .navigationTitle("Color")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            TitleTextView(title: "View Preview")
            
            Text("NavigationBar")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            HStack{
                Spacer()
                
                NavigationStack {
                    Text("Navigation Bar")
                        .navigationTitle("Title here")
                        .toolbarColorScheme(.dark, for: .navigationBar)
                        .toolbarBackground(Color.green)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbar {
                            ToolbarItem {
                                Button("Button") { }
                            }
                        }
                }
                .frame(width: 300, height: 250)
 
                Spacer()
            }
            
            Spacer()
            
            VStack {
                BulletPointText(text: "화면 상단에 위치하는 바로, 타이틀, 네비게이션 버튼, 기타 컨트롤을 포함할 수 있음.")
                BulletPointText(text: " 사용자는 NavigationBar를 통해 앱 내에서의 위치를 파악하고, 이전 화면으로 돌아갈 수 있는 버튼 등을 사용.")
                    .padding(.top, 5)
            }

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var codePreviewSection: some View {
        VStack(spacing: 20) {
            TitleTextView(title: "Code Preview")
            
            CodePreviewView(code: returnCode(), copyAction: copyCode, showCopy: true)
                
            TitleTextView(title: "Base Code")
            
            CodePreviewView(code: basecode(), copyAction: copyCode, showCopy: false)
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
                ScrollView{
                    // Some content here
                }
                .navigationTitle("Title here")
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.blue)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem {
                        Button("Button") { /* Some action here*/ }
                    }
                }
            }
        }
        """
    }
    
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
    
    func returnCode() -> String {
        return """
           NavigationStack {
               Text("Navigation Bar")
                   .navigationTitle("Title here")
                   .toolbarColorScheme(.dark, for: .navigationBar)
                   .toolbarBackground(Color.green)
                   .toolbarBackground(.visible, for: .navigationBar)
                   .toolbar {
                       ToolbarItem {
                           Button("Button") { /* Some action here*/ }
                       }
                   }
           }
           """
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
    NavigationBarContatiner()
}
