//
//  AlertView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 5/1/24.
//

import SwiftUI

struct AlertView: View, ViewPorotocol{
    @State var showAlert: Bool = false
    @State private var pickerCnt: Int = 0
    
    
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
            .navigationTitle("Alert View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    //  뷰 프리뷰
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            TitleTextView(title: "View Preview")
            
            Text("AlertView")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker(selection: $pickerCnt, label: Text("Picker")) {
                Text("one button alert").tag(0)
                Text("two button alert").tag(1)
                
            }
            .pickerStyle(.segmented)
            
            Divider()
            
            switch pickerCnt {
            case 1:
                previewTwoAelrtButton
                    .frame(maxWidth: .infinity, alignment: .center)
            default:
                previewOneAelrtButton
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var previewOneAelrtButton: some View {
        
        Button("One Button Alert"){
            showAlert.toggle()
        }
        .alert("This is One Button Alert", isPresented: $showAlert, actions: {
            Button("OK") {
                //Button Action
            }
            
        }, message: {
            Text("This is Alert Message")
        })
        .buttonStyle(.bordered)
        
        
        
    }
    private var previewTwoAelrtButton: some View {
        
        Button("Two Button Alert"){
            showAlert.toggle()
        }
        .alert("This is Two Button Alert", isPresented: $showAlert, actions: {
            
            Button(role: .destructive) {
                //Button Action
            } label : {
                Text("Destructive")
            }
            
        }, message: {
            Text("If you use Role for the button, you will basically have Cancel button,\nbut if you set roll to .cancel, you will only have Cancel button")
        })
        .buttonStyle(.bordered)
        
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
    
    
    func copyCode(_ code: String) {
        print("")
    }
    
    func didDismiss() {
        print("")
    }
    
    func sheetViewCode() -> String {
        switch pickerCnt {
        case 1:
            """
            Button("Two Button Alert"){
                showAlert.toggle()
            }
            .alert("This is Two Button Alert", isPresented: $showAlert, actions: {
                
                Button(role: .destructive) {
                    //Button Action
                } label : {
                    Text("Destructive")
                }
                
            }, message: {
                Text("If you use Role for the button, you will basically have Cancel button,\nbut if you set roll to .cancel, you will only have Cancel button")
            })
            """
        default:
            """
            Button("One Button Alert"){
                showAlert.toggle()
            }
            .alert("This is One Button Alert", isPresented: $showAlert, actions: {
                Button("OK") {
                    //Button Action
                }
                
            }, message: {
                Text("This is Alert Message")
            })
            """
        }
    }
    
    func basecode() -> String {
    """
    func alert<S, A, M, T>(
        _ title: S,
        isPresented: Binding<Bool>,
        presenting data: T?,
        @ViewBuilder actions: (T) -> A,
        @ViewBuilder message: (T) -> M
    ) -> some View where S : StringProtocol, A : View, M : View
    """
    }
}

#Preview {
    AlertView()
}
