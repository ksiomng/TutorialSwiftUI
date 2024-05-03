//
//  ContextMenu.swift
//  TutorialSwiftUI
//
//  Created by Song Kim on 5/1/24.
//

import SwiftUI
import CodeEditor

private let menuItems = ContextMenu {
    Button ("Button1",systemImage: "heart"){}
    Button ("Button2"){}
}

struct ContextMenuView: View {
    @State private var ShowMenu = true
    @State private var modArr = [TextModifier]()
    
    var body: some View {
        VStack {
            
            // 선택된 수정자를 적용한 텍스트 뷰
            let modifiedText = Text("Turtle Rock")
                .apply(modifiers: modArr)
            modifiedText
                .contextMenu(ShowMenu ? menuItems : nil)
                .frame(minHeight: 100)
                .font(.largeTitle)
            
            // 선택된 수정자를 적용한 텍스트 뷰
            let modifiedCode = generateCode(modifiers: modArr, firstCode: """
            private let menuItems = ContextMenu {
                Button(\"btn\",systemImage:\"heart\"){}
                Button(\"btn\"){}
            }
            Text(\"Turtle Rock\")
                .contextMenu(ShowMenu ? menuItem : nil)
            """
            )
            VStack(alignment: .leading) {
                CodeEditor(
                    source: modifiedCode,
                    language: .javascript,
                    theme: .agate
                )
            }
            .cornerRadius(10)
            .padding([.trailing, .leading, .bottom])
            
            MenuButton(modArr: $modArr)
            
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
    ContextMenuView()
}
