//
//  NavigationBarView.swift
//  TutorialSwiftUI
//
//  Created by 황규상 on 5/2/24.
//

import SwiftUI
import CodeEditor

struct NavigationBarContatiner: View {
    @State private var isPresented = false
    private var original:String = """
        struct ContentView: View {
            var body: some View {
                ScrollView{
                    // Some content here
                }
                .navigationTitle("Title here")
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.blue)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem {
                        Button("Button") { /* Some action here*/ }
                    }
                }
            }
        }
        """
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Navigation Bar")
                        .textCase(nil)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                    ) {
                        Text("""
                                 SwiftUI Navigation Bar는 사용자가 App에서 서로 다른 View 사이를 이동할 수 있도록 하는 UI 요소입니다.일반적으로 계층적 Navigation 경험을 제공하는 데 사용됩니다.
                                 """)
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
                        VStack {
                            NavigationLink(destination: ChildView()) {
                                Text("Navigation Bar preview")
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        .cornerRadius(10)
                        .padding()
                        .padding(.top, -20)
                        .listRowBackground(Color.clear)
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
                            .frame(width: 350, height: 290)
                        }
                        .cornerRadius(10)
                        .padding()
                        .padding(.top, -20)
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle("Navigation Bar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChildView: View {
//    @State var flag = true
    private var childViewOriginal:String = """
        var body: some View {
            NavigationStack {
                Section(header: Text("Current Screen Code")
                    .textCase(nil)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
                ) {
                    VStack(alignment: .center) {
                        CodeEditor(
                            source: childViewOriginal,
                            language: .swift,
                            theme: .agate
                        )
                        .frame(width: 350, height: 290)
                    }
                    .cornerRadius(10)
                }
                
                .navigationTitle("Title here")
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(Color.gray)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem {
                        Button("Button") { /* Some action here*/ }
                    }
                }
            }
        }
        """
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Current Screen Code")
                    .textCase(nil)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    VStack(alignment: .center) {
                        CodeEditor(
                            source: childViewOriginal,
                            language: .swift,
                            theme: .agate
                        )
                        .frame(width: 350, height: 600)
                    }
                    .cornerRadius(10)
                }
                
                //            Toggle(isOn: $flag, label: {
                //                Text("NavigationBarTitle DisplayMode")
                //            }).padding()
            }
            .navigationTitle("Title here")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.gray)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem {
                    Button("Button") { print(":asd") }
                }
            }
        }
    }
}

#Preview {
    NavigationBarContatiner()
}
