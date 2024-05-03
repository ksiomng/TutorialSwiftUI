//
//  LinkContainer.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/2/24.
//

import SwiftUI
import CodeEditor

struct LinkContainer: View {
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                viewPreviewSection
                codePreviewSection
            }
            .padding()
            .frame(maxHeight: .infinity)
            .navigationTitle("Link")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            TitleTextView(title: "View Preview")
            
            Text("Link")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            HStack{
                Spacer()
                
                Link("Visit Apple", destination: URL(string: "https://www.apple.com")!)
                    .frame(height: 80)
 
                Spacer()
            }
            
            Spacer()
            
            VStack {
                BulletPointText(text: "URL이나 다른 외부 목적지로 연결할 수 있는 Conponent.")
                BulletPointText(text: "Link Conponent는 App 내부의 Navigation뿐만 아니라 외부 Resource와의 연결도 용이.")
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
        Link(/*Text Here (String)*/, destination: URL(string: /*URL Here (String)*/)!)
        """
    }
    
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
    
    func returnCode() -> String {
        return """
               Link("Visit Apple", destination: URL(string: "https://www.apple.com")!)
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
    LinkContainer()
}
