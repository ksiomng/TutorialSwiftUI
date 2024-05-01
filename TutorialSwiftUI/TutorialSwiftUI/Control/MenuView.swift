//
//  MenuVIew.swift
//  TutorialSwiftUI
//
//  Created by Song Kim on 5/1/24.
//

import SwiftUI
import CodeEditor

struct MenuView: View {
    @State private var modArr = [TextModifier]()
    
    var body: some View {
        VStack {
           MenuButton(modArr: $modArr)
            
            // 선택된 수정자를 적용한 텍스트 뷰
            let modifiedText =             
            Menu("Menu") {
                Button("Button1") {}
                Button("Button2") {}
            }
                .apply(modifiers: modArr)
            modifiedText
                .frame(minHeight: 100)
                .font(.largeTitle)
            
            // 선택된 수정자를 적용한 텍스트 뷰
            let modifiedCode = generateCode(modifiers: modArr, firstCode: "Menu(\"Menu\"){\nButton(\"Button1\"){}  \nButton(\"Button2\"){}\n}")
            VStack(alignment: .leading) {
                CodeEditor(
                    source: modifiedCode,
                    language: .javascript,
                    theme: .agate
                )
            }
            .cornerRadius(10)
            .padding([.trailing, .leading])
            
            
            // 선택된 수정자를 나열한 리스트
            List {
                ForEach(modArr.indices, id: \.self) { index in
                    Text("🜸 \(modArr[index].description)")
                }
                .onDelete(perform: { indexSet in
                    modArr.remove(atOffsets: indexSet)
                })
            }
            .scrollContentBackground(.hidden)
            .frame(height: 400)
        }
    }
}

#Preview {
    MenuView()
}
