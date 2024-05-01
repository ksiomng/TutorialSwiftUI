//
//  FullScreenCoverView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 5/1/24.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let body: String
}

struct FullScreenCoverView: View, ViewPorotocol {
    @State private var isPresented: Bool = false
    @State private var pickerCnt: Int = 0
    @State private var data: Item?
    
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
            .navigationTitle("Full Screen Cover")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    //  뷰 프리뷰
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {

            TitleTextView(title: "View Preview")
            
            Text("Full Screen Cover")
                .frame(maxWidth: .infinity, alignment: .leading)

            Picker(selection: $pickerCnt, label: Text("Picker")) {
                Text("No Have Item").tag(0)
                Text("Have Item").tag(1)
            }
            .pickerStyle(.segmented)
            
            Divider()
            
            switch pickerCnt {
            case 1:
                haveItemPreiViewbutton
                    .frame(maxWidth: .infinity, alignment: .center)
            default:
                previewButton
                    .frame(maxWidth: .infinity, alignment: .center)
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
            isPresented = true
        } label: {
            Text("Show Preview Button")
                .foregroundColor(.white)
                .bold()
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .fullScreenCover(isPresented: $isPresented, onDismiss: didDismiss) {
            Button("Dismiss") {
                didDismiss()
            }
        }
        
       
    }
    
    private var haveItemPreiViewbutton:some View {
        Button {
            data = Item(title: "This is Item Title",
                        body: "This is Item Body")
            isPresented = true
        } label: {
            Text("Show Preview Button")
                .foregroundColor(.white)
                .bold()
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .fullScreenCover(item: $data, onDismiss: didDismiss) { data in
            Text("\(data.title)")
            Text("\(data.body)")
            
            Button("Dismiss") {
                self.data = nil
            }
        }
    }
    
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
    
    // Dismiss Action
    func didDismiss() {
        isPresented = false
    }
    
    func sheetViewCode() -> String {
        switch pickerCnt {
        case 1:
            """
            @State private var isPresented: Bool = false
            @State private var data: Item?\n
            Button {
                data = Item(title: "This is Item Title",
                            body: "This is Item Body")
                isPresented = true
            } label: {
                Text("Show Preview Button")
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .fullScreenCover(item: $data, onDismiss: didDismiss) { data in
                Text("\\(data.title)")
                Text("\\(data.body)")
                
                Button("Dismiss") {
                    self.data = nil
                }
            }
            """
        default:
           """
           @State private var isPresented: Bool = false\n
           Button {
              isPresented = true
           } label: {
              Text("Show Preview Button")
                  .foregroundColor(.white)
                  .bold()
                  .padding()
                  .background(Color.blue)
                  .cornerRadius(10)
           }
           .fullScreenCover(isPresented: $isPresented, onDismiss: didDismiss) {
              Button("Dismiss") {
                  didDismiss()
              }
           }
           """
        }
   
    }
    
    // Base code
    func basecode() -> String {
        switch pickerCnt {
    
        case 1:
            return
        """
        func fullScreenCover<Item, Content>(
            item: Binding<Item?>,
            onDismiss: (() -> Void)? = nil,
            @ViewBuilder content: @escaping (Item) -> Content
        ) -> some View where Item : Identifiable, Content : View
        """
        default:
            return        
        """
        func fullScreenCover<Content>(
            isPresented: Binding<Bool>,
            onDismiss: (() -> Void)? = nil,
            @ViewBuilder content: @escaping () -> Content
        ) -> some View where Content : View
        """
        }
 
     
    }
    
    
}

#Preview {
    NavigationStack {
        FullScreenCoverView()
    }
}
