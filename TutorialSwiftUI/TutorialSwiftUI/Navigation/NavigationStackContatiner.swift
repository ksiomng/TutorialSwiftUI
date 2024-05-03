//
//  NavigationStackContainer.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/2/24.
//

import SwiftUI
import CodeEditor

struct NavigationStackContatiner: View {
    private var original:String = """
    struct ContentView: View {
        var body: some View {
            NavigationStack{
                Text("Hello, World!")
            }
        }
    }
    """
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Navigation Stack")
                        .textCase(nil)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                    ) {
                        Text("""
                             NavigationStack은 SwiftUI에서 새롭게 도입된 네비게이션 구조로, NavigationView를 대체하여 iOS 16부터 사용되기 시작했습니다. 이 구조는 앱 내에서 화면 전환을 관리하는데 사용됩니다. 특히, 선언적인 스타일의 SwiftUI에 맞게 설계되어 코드의 가독성과 유지 관리가 용이합니다.\n
                             NavigationStack은 스택처럼 작동하며, 사용자가 새 화면으로 이동할 때마다 화면이 스택에 쌓이고, 이전 화면으로 돌아갈 때는 스택에서 제거됩니다. 이를 통해 사용자는 앱 내에서 깊이 있는 네비게이션 경로를 생성하고 관리할 수 있습니다.
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
            .navigationTitle("Navigation Stack")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStackContatiner()
}
