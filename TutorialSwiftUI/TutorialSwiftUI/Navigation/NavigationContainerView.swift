//
//  NavigationContainerView.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/1/24.
//

import SwiftUI
import CodeEditor

struct NavigationContainerView: View {
    @State private var isPresented = false
    private var original:String = """
    struct ContentView: View {
        var body: some View {
            NavigationView{
                Text("Hello, World!")
            }
        }
    }
    """
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Navigation View")
                        .textCase(nil)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                    ) {
                        Text("""
                             NavigationView는 SwiftUI의 초기 버전에서 사용되어 온 컴포넌트로, 사용자 인터페이스에서 계층적인 데이터 구조를 탐색할 수 있게 해주는 네비게이션 컨테이너입니다. 이는 사용자가 앱 내의 다양한 화면 사이를 이동할 수 있게 도와줍니다. iOS 16 이후로는 NavigationStack에 의해 대체되었지만, 여전히 기존 코드에서 사용되거나 특정 상황에서 유용하게 사용될 수 있습니다. \n\n NavigationView를 사용하면 네비게이션 바를 포함한 화면 구조를 쉽게 구현할 수 있으며, 네비게이션 링크(NavigationLink)를 통해 다른 뷰로의 전환을 관리할 수 있습니다.
                             """)
                            .padding()
                            .padding(.top, -20)
                            .font(.system(size: 16))
                            .lineSpacing(8)
                            .listRowBackground(Color.clear)
                            .frame(width: 350)
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
                            .frame(width: 350, height: 120)
                        }
                        .cornerRadius(10)
                        .padding()
                        .padding(.top, -20)
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Navigation View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationContainerView()
}
