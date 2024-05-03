//
//  NavigationLInkContainer.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/2/24.
//

import SwiftUI
import CodeEditor

struct NavigationLinkContainer: View {
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
            
            Text("NavigationLink")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            HStack{
                Spacer()
                
                NavigationStack {
                    List {
                        NavigationLink(destination: Text("Detail View1")) {
                            Text("Link1")
                        }
                        NavigationLink(destination: Text("Detail View2")) {
                            Text("Link2")
                        }
                        NavigationLink(destination: Text("Detail View3")) {
                            Text("Link3")
                        }
                    }
                }
                .frame(width: 300, height: 200)
 
                Spacer()
            }
            
            Spacer()
            
            VStack {
                BulletPointText(text: "특정 뷰에서 다른 뷰로 이동하는 컴포넌트로 사용자가 탭할 때 지정된 목적지 뷰로 이동.")
                BulletPointText(text: "주로 리스트에서 세부 정보 화면으로 넘어갈 때 사용.")
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
        NavigationLink(destination: /* View of destination here */ ) {
            // How the navigationLink looks here
        }
        """
    }
    
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
    
    func returnCode() -> String {
        return """
               NavigationStack {
                   List {
                       NavigationLink(destination: Text("Detail View1")) {
                           Text("Link1")
                       }
                       NavigationLink(destination: Text("Detail View2")) {
                           Text("Link2")
                       }
                       NavigationLink(destination: Text("Detail View3")) {
                           Text("Link3")
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
    NavigationLinkContainer()
}
