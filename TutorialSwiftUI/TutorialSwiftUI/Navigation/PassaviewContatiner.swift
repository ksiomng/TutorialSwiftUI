//
//  PassaviewContatiner.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/2/24.
//

import SwiftUI
import CodeEditor

struct PassaviewContatiner: View {
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                viewPreviewSection
                codePreviewSection
            }
            .padding()
            .frame(maxHeight: .infinity)
            .navigationTitle("Pass a view")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            TitleTextView(title: "View Preview")
            
            Text("Pass a view")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            HStack{
                Spacer()
                
                NavigationLink(destination: PassaviewContainerExample()) {
                    Text("Pass a view Code Preview")
                }
                
                Spacer()
            }
            
            Spacer()
            
            VStack {
                BulletPointText(text: "View를 다른 View로 전달하는 방식을 설명하는 용어.")
                BulletPointText(text: "예를 들어, NavigationLink를 사용하여 상세 정보 화면을 표시할 때, 전달할 데이터를 포함한 뷰를 목적지 뷰로 넘겨줄 수 있음.")
                    .padding()
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
               struct PassaviewContainerExample: View {
                   var body: some View {
                       VStack {
                           Spacer()
                           Text("첫 번째 View 구조체 상단")
                           Divider()
                               .frame(height: 1)
                               .background(Color.red)
                           Spacer()
                           TemplateView(subView: SomeSubview())
                           Spacer()
                           Divider()
                               .frame(height: 1)
                               .background(Color.red)
                           Text("첫 번째 View 구조체 하단")
                           Spacer()
                       }
                       .padding(.vertical)
                   }
               }

               struct SomeSubview: View {
                   var body: some View {
                       Spacer()
                       Divider()
                           .frame(height: 1)
                           .background(Color.green)
                       Text("두 번째 View 구조체에서 파라미터로 받은 4번째 View")
                           .padding(.vertical)
                       Divider()
                           .frame(height: 1)
                           .background(Color.green)
                       Spacer()
                   }
               }

               struct TemplateView<Content: View>: View {
                   let subView: Content
                   
                   var body: some View {
                       VStack {
                           Spacer()
                           Text("첫 번째 View 구조체에서 파라미터로 받은")
                           Text("두 번째 View 상단")
                           Divider()
                               .frame(height: 1)
                               .background(Color.blue)
                           subView
                           Divider()
                               .frame(height: 1)
                               .background(Color.blue)
                           Text("첫 번째 View 구조체에서 파라미터로 받은")
                           Text("두 번째 View 하단")
                           Spacer()
                       }
                   }
               }

               #Preview {
                   PassaviewContainerExample()
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
    PassaviewContatiner()
}
