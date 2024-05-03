//
//  SliderView.swift
//  TutorialSwiftUI
//
//  Created by Song Kim on 5/1/24.
//

import SwiftUI
import CodeEditor

struct SliderView: View {
    @State private var sliderValue = 0.0
    @State private var modArr = [TextModifier]()
    
    var body: some View {
        VStack {
            // 선택된 수정자를 적용한 텍스트 뷰
            VStack {
                Slider(value: $sliderValue, in: -100...100, step: 1)
                let modifiedText = Text("\(sliderValue)")
                    .apply(modifiers: modArr)
                modifiedText
            }
                .padding()
                .frame(minHeight: 100)
                .font(.largeTitle)
            
            // 선택된 수정자를 적용한 텍스트 뷰
            let modifiedCode = generateCode(modifiers: modArr, firstCode: """
                Slider(value: $sliderValue, in: -100...100, setp: 1)
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
    SliderView()
}
