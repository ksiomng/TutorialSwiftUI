//
//  PassaviewContatiner.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/2/24.
//

import SwiftUI
import CodeEditor

struct PassaviewContatiner: View {
    private var original:String = """
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
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Pass a view")
                    .textCase(nil)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                ) {
                    Text("""
                             Pass a view라는 용어는 일반적으로 뷰를 다른 뷰에 매개변수로 전달하는 것을 의미합니다. 이는 SwiftUI의 구조체 기반의 디자인을 활용해 뷰 또는 뷰 모델을 다른 뷰로 전달하는 패턴을 말합니다. 이는 직접적인 SwiftUI의 구성 요소는 아니지만, 개발자들 사이에서 흔히 사용되는 개념입니다.
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
                    NavigationLink(destination: PassaviewContainerExample()) {
                        Text("Pass a view Code Preview")
                    }
                }
                
                Section(header: Text("Preview Code")
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
                        .frame(width: 350, height: 1000)
                    }
                    .cornerRadius(10)
                    .padding()
                    .padding(.top, -20)
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Pass a view")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PassaviewContatiner()
}
