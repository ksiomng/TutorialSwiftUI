//
//  NavigationLInkContainer.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/2/24.
//

import SwiftUI
import CodeEditor

struct NavigationLinkContainer: View {
    private var original:String = """
        NavigationLink(destination: /* View of destination here */ ) {
            // How the navigationLink looks here
        }
        """
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Navigation Link")
                    .textCase(nil)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                ) {
                    Text("""
                             NavigationLink는 SwiftUI에서 다른 뷰로 이동할 수 있게 해주는 컴포넌트입니다. 사용자가 NavigationLink를 탭하면 지정된 목적지 뷰(Destination View)로 이동하게 됩니다. 이 컴포넌트는 내비게이션 스택을 자동으로 관리해 주기 때문에 복잡한 내비게이션 로직을 직접 처리할 필요가 없습니다.
                             """)
                    .padding()
                    .padding(.top, -20)
                    .font(.system(size: 16))
                    .lineSpacing(8)
                    .listRowBackground(Color.clear)
                    .frame(width: 350)
                }
                
                Section(header: Text("Preview")
                    .textCase(nil)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                ) {
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
                
                Section(header: Text("Base Code")
                    .textCase(nil)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                ) {
                    VStack(alignment: .center) {
                        CodeEditor(
                            source: original,
                            language: .swift,
                            theme: .agate
                        )
                        .frame(width: 350, height: 100)
                    }
                    .cornerRadius(10)
                    .padding()
                    .padding(.top, -20)
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Navigation Link")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationLinkContainer()
}
