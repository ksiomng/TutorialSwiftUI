//
//  NavigationContainerView.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/1/24.
//

import SwiftUI
import CodeEditor

struct PresentNavigationView: View {
    var body: some View {
        NavigationView {
            Text("Navigation View")
                .font(.largeTitle)
                .padding()
        }
    }
}

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
                        Text("NavigationView 는 SwiftUI의 가장 중요한 구성 요소 중 하나입니다. 화면을 쉽게 Push 와 Pop할 수 있으며, 사용자에게 명확하고 계층적인 방식으로 정보를 제공할 수 있습니다")
                            .padding()
                            .padding(.top, -20)
                            .font(.system(size: 16))
                            .lineSpacing(8)
                            .listRowBackground(Color.clear)
                            .frame(width: 350)
                    }
                    
                    Section(header: Text("View Preview")
                        .textCase(nil)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                    ) {
                        HStack {
                            Spacer()
                            Button("Navigation View") {
                                isPresented.toggle()
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            Spacer()
                        }
                        .cornerRadius(10)
                        .padding()
                        .padding(.top, -20)
                    }
                    .listRowBackground(Color.clear)
                    .frame(width: 350)
                    
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
        .sheet(isPresented: $isPresented) {
            PresentNavigationView()
        }
    }
}

#Preview {
    NavigationContainerView()
}
