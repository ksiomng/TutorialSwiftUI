//
//  PopoverView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 5/1/24.
//

import SwiftUI

struct PopoverView: View, ViewPorotocol {
    
    @State var isPresented: Bool = false
    
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
            .navigationTitle("Popover View")
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
        .popover(isPresented: $isPresented){
            popOverView
        }
    }
    
    // Code Preview Section
    var codePreviewSection: some View {
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
    
    private var popOverView: some View {
        VStack(spacing: 10) {
            Text("This is Popover View")
            Divider()
            Text("If you use an iPhone, it will look the same as a sheet")
            Text("Check it out with an iPad or MacBook")
        }
        .padding()
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
        @State var isPresented: Bool = false
        
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
        .popover(isPresented: $isPresented){
            popOverView
        }
        """
    }
    
    // Base code
    func basecode() -> String {
        """
        func popover<Content>(
            isPresented: Binding<Bool>,
            attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds),
            arrowEdge: Edge = .top,
            @ViewBuilder content: @escaping () -> Content
        ) -> some View where Content : View
        """
    }
}

#Preview {
    NavigationStack {
        PopoverView()
    }
}
