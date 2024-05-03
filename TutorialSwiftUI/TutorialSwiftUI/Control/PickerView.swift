//
//  PickerView.swift
//  TutorialSwiftUI
//
//  Created by Song Kim on 5/1/24.
//

import SwiftUI
import CodeEditor

struct PickerView: View {
    var colors = ["red", "green", "blue"]
    @State var selectedColor = ""
    @State private var modArr = [TextModifier]()
    
    var body: some View {
        VStack {
            // 선택된 수정자를 적용한 텍스트 뷰
            Picker("", selection: $selectedColor) {
                ForEach(colors, id: \.self) {
                    Text($0)
                }
            }
            .apply(modifiers: modArr)
            .pickerStyle(.wheel)
            .padding()
            .frame(minHeight: 100)
            .font(.largeTitle)
            
            // 선택된 수정자를 적용한 텍스트 뷰
            let modifiedCode = generateCode(modifiers: modArr, firstCode: "var colors = [\"red\", \"green\", \"blue\"]\n@State var selectedColor = \"\"\n\nPicker(\"\", selection: $selectedColor) {\nForEach(colors, id: \\.self) {\nText($0)\n}}\n.pickerStyle(.wheel)")
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
    PickerView()
}
