//
//  SheetView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 5/1/24.
//

import SwiftUI

struct SheetView: View, ViewPorotocol {
    @State private var isPresented: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 뷰 프리뷰
                viewPreviewSection
                  

                // 코드 프리뷰
                codePreviewSection
                
                Spacer()
            }
            .padding()
            .navigationTitle("Sheet View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    //  뷰 프리뷰
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {

            TitleTextView(title: "View Preview")
            
            Text("SheetView")
                .frame(maxWidth: .infinity, alignment: .leading)


            
            Divider()
            
            previewButton
                .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    // Code Preview Section
    private var codePreviewSection: some View {
        VStack(spacing: 20) {
            TitleTextView(title: "Code Preview")
            
            CodePreviewView(code: sheetViewCode(), copyAction: copyCode,showCopy: true)
            
            TitleTextView(title: "Base Code")
            
            CodePreviewView(code: basecode(), copyAction: copyCode, showCopy: false)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    
    // 코드 프리뷰
    private var previewButton: some View {
        Button {
            isPresented.toggle()
        } label: {
            Text("Show Preview Button")
                .foregroundColor(.white)
                .bold()
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .sheet(isPresented: $isPresented, onDismiss: didDismiss) {
            PresentSheetView()
        }
    }
    
    
    
    // 복사
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
    
    // Dismiss Action
    func didDismiss() {
       
    }
    
    // Code Preview
    func sheetViewCode() -> String {
        """
        Button(action: {
            isPresented.toggle()
        }) {
            Text("Show Preview Button")
                .foregroundColor(.white)
                .bold()
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .sheet(isPresented: $isPresented, onDismiss: didDismiss) {
            PresentSheetView()
        }
        """
    }
    
    // Base code
    func basecode() -> String {
        """
        func sheet<Content>(
            isPresented: Binding<Bool>,
            onDismiss: (() -> Void)? = nil,
            @ViewBuilder content: @escaping () -> Content
        ) -> some View where Content : View {
            // Implementation
        }
        """
    }
}

struct PresentSheetView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    NavigationStack {
        SheetView()
    }
    
}
