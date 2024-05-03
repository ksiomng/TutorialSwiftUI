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
                Button("Bold: Make text bold") {
                    modArr.append(.bold)
                }
                Button("Italic: Make text italic") {
                    modArr.append(.italic)
                }
                Button("Underline: \nUnderline text") {
                    modArr.append(.underline)
                }
                Button("Padding: Add padding around text") {
                    modArr.append(.padding)
                }
                Button("Foreground Color: Change text color") {
                    modArr.append(.foregroundStyle)
                }
                Button("Background: Add background color") {
                    modArr.append(.background)
                }
                Button("Corner Radius: Round the corners") {
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
        .cornerRadius(10)
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .frame(height: 300)
    }
}
