import SwiftUI

struct TextView: View {
    @State private var modArr = [TextModifier]()
    
    var body: some View {
        VStack {
            // 수정자를 선택할 수 있는 버튼이 있는 메뉴
            HStack {
                Spacer()
                Menu {
                    Button("Bold") {
                        modArr.append(.bold)
                    }
                    Button("Italic") {
                        modArr.append(.italic)
                    }
                    Button("Text Color") {
                        modArr.append(.foregroundStyle)
                    }
                    Button("Padding") {
                        modArr.append(.padding)
                    }
                    Button("Background") {
                        modArr.append(.background)
                    }
                } label: {
                    Text("Add")
                }
                .padding()
                .foregroundStyle(Color.gray)
            }
            .padding(.trailing)

            // 선택된 수정자를 적용한 텍스트 뷰
            let modifiedText = Text("Hello").apply(modifiers: modArr)
            modifiedText
                .frame(minHeight: 50)
            

            // 선택된 수정자를 적용한 텍스트 뷰
            let modifiedCode = generateCode(modifiers: modArr)
            Text(modifiedCode)
                .frame(minWidth: 330, minHeight: 100)
                .padding()
                .background(.placeholder)
                .cornerRadius(10)
            

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
        }
    }
    private func generateCode(modifiers: [TextModifier]) -> String {
            var code = "Text(\"Hello\")"
            for modifier in modifiers {
                switch modifier {
                case .bold:
                    code += "\n   .bold()"
                case .italic:
                    code += "\n   .italic()"
                case .foregroundStyle:
                    code += "\n   .foregroundStyle(Color.yellow)"
                case .padding:
                    code += "\n   .padding()"
                case .background:
                    code += "\n   .background(.blue)"
                }
            }
            return code
        }
}

// 가능한 텍스트 수정자
enum TextModifier {
    case bold
    case italic
    case foregroundStyle
    case padding
    case background

    var description: String {
        switch self {
        case .bold: return ".bold()"
        case .italic: return ".italic()"
        case .foregroundStyle: return ".foregroundStyle(Color.yellow)"
        case .padding: return ".padding()"
        case .background: return ".background(.blue)"
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
        case .foregroundStyle: 
            text.foregroundStyle(Color.yellow)
        case .padding:
            text.padding()
        case .background:
            text.background(.blue)
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

#Preview {
    TextView()
}
