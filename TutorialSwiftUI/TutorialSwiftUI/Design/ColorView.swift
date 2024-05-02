//
//  ColorView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 5/1/24.
//

import SwiftUI

struct ColorView: View {
    @State private var backgroundColorIndex = 0
    @State private var foregreoundColorIndex = 1
    @State private var baseColors: [Color] = [.white, .black, .gray, .green, .blue, .red, .purple, .orange,.yellow,.brown,.gray]
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                // 뷰 프리뷰
                viewPreviewSection
                
                // 코드 프리뷰
                VStack {
                    
                    HStack {
                        Text("BackGround Color")
                        Spacer()
                        
                        Picker("backgroundColor", selection: $backgroundColorIndex) {
                            ForEach(0..<baseColors.count, id:\.self) { index in
                                Text(baseColors[index].description)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Foreground Color")
                        
                        Spacer()
                        
                        Picker("backgroundColor", selection: $foregreoundColorIndex) {
                            ForEach(0..<baseColors.count, id:\.self) { index in
                                Text(baseColors[index].description)
                            }
                        }
                        
                    }
                    
                }
                .frame(maxWidth: .infinity)
                
                
                codePreviewSection
            }
            .padding()
            .frame(maxHeight: .infinity) // 내부 VStack의 세로 크기를 최대화
            .navigationTitle("Color")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            TitleTextView(title: "View Preview")
            
            Text("Color")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            HStack{
                Spacer()
                Text("Hello, World!")
                    .padding()
                    .background(baseColors[backgroundColorIndex])
                    .foregroundStyle(baseColors[foregreoundColorIndex])
                Spacer()
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
        Text("Hello, World")
            .background(.white)
            .foregroundStyle(.white)
        """
    }
    
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
    
    func a(modifier: Modifire) -> String {
        switch modifier {
        case .bold:
            return ".bold()"
        case .frame:
            return ".frame()"
        case .background:
            return ".background(.red)"
        default: return ""
        }
    }
    
    func returnCode() -> String {
        
        return """
               Text(\"Hello, World!\")
                   .background(.\(baseColors[backgroundColorIndex]))
                   .foregroundStyle(.\(baseColors[foregreoundColorIndex]))
               """
    }
    
}




#Preview {
    ColorView()
}
