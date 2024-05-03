//
//  MenuButton.swift
//  TutorialSwiftUI
//
//  Created by Song Kim on 5/1/24.
//
import Foundation
import SwiftUI

func generateCode(modifiers: [TextModifier], firstCode: String) -> String {
    var code = firstCode
    
    for modifier in modifiers {
        switch modifier {
        case .bold:
            code += "\n.bold()"
        case .italic:
            code += "\n.italic()"
        case .underline:
            code += "\n.underline()"
        case .padding:
            code += "\n.padding()"
        case .foregroundStyle:
            code += "\n.foregroundStyle(Color.yellow)"
        case .background:
            code += "\n.background(.gary)"
        case .cornerRadius:
            code += "\n.cornerRadius(10)"
        }
    }
    return code
}

// 가능한 텍스트 수정자
enum TextModifier {
    case bold
    case italic
    case underline
    case padding
    case foregroundStyle
    case background
    case cornerRadius
    
    var description: String {
        switch self {
        case .bold: return "bold"
        case .italic: return "italic"
        case .underline: return "underline"
        case .padding: return "padding"
        case .foregroundStyle: return "foregroundStyle"
        case .background: return "background"
        case .cornerRadius: return "cornerRadius"
        }
    }
    
    // 선택된 수정자를 텍스트에 적용하는 함수
    @ViewBuilder
    func apply(to text: some View) -> some View {
        switch self {
        case .bold:
            text.bold()
        case .italic:
            text.italic()
        case .underline:
            text.underline()
        case .padding:
            text.padding()
        case .foregroundStyle:
            text.foregroundStyle(Color.yellow)
        case .background:
            text.background(.gray)
        case .cornerRadius:
            text.cornerRadius(10)
        }
    }
}

extension View {
    // 선택된 수정자를 적용한 새로운 텍스트 반환
    func apply(modifiers: [TextModifier]) -> some View {
        var modifiedText: any View = self
        for modifier in modifiers {
            modifiedText = modifier.apply(to: modifiedText)
        }
        return AnyView(modifiedText)
    }
}

// 메뉴 뷰
struct MenuButton: View {
    @Binding var modArr: [TextModifier]  // TextView에서 modArr을 전달 받음
    
    var body: some View {
        HStack {
            Spacer()
            Menu(content: {
                Button("Bold: 텍스트를 굵게") {
                    modArr.append(.bold)
                }
                Button("Italic: 이탤릭체") {
                    modArr.append(.italic)
                }
                Button("Underline: 밑줄") {
                    modArr.append(.underline)
                }
                Button("Padding: 주변에 패딩 추가") {
                    modArr.append(.padding)
                }
                Button("Foreground Color: 글자색 바꾸기") {
                    modArr.append(.foregroundStyle)
                }
                Button("Background: 배경색 추가하기") {
                    modArr.append(.background)
                }
                Button("Corner Radius: 모서리 둥글게") {
                    modArr.append(.cornerRadius)
                }
            }) {
                Text("Add  ")
            }
            .padding()
            .foregroundStyle(Color.gray)
        }
    }
}


struct AddListView: View {
    @Binding var modArr: [TextModifier]
    
    var body: some View {
        List {
            ForEach(modArr.indices, id: \.self) { index in
                Text("\(modArr[index].description)")
            }
            .onDelete(perform: { indexSet in
                modArr.remove(atOffsets: indexSet)
            })
        }
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(Color(uiColor: .systemBackground))
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .cornerRadius(10)
    }
}
