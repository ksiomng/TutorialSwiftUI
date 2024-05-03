//
//  LinkContainer.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/2/24.
//

import SwiftUI
import CodeEditor

struct LinkContainer: View {
    private var original:String = "Link(/*Text Here (String)*/, destination: URL(string: /*URL Here (String)*/)!)"
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Link")
                    .textCase(nil)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                ) {
                    Text("""
                             Link는 웹 URL로 연결하는 링크를 생성할 때 사용됩니다. 사용자가 링크를 클릭하면, 기본 웹 브라우저를 통해 해당 URL이 열립니다.\n주로 외부 웹사이트로의 링크를 제공할 때 사용됩니다. 또 파일 시스템의 Location을 표시할 때, 특정 App의 경로를 나타내기도 한다.
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
                    Link("Visit Apple", destination: URL(string: "https://www.apple.com")!)
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
            .navigationTitle("Link")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LinkContainer()
}
