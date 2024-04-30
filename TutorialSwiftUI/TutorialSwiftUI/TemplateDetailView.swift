/*
 HighlightSwift : https://github.com/appstefan/highlightswift.git
 CodeEditor : https://github.com/ZeeZide/CodeEditor.git
 */

import SwiftUI
import HighlightSwift
import CodeEditor

/// 사용할 모디파이어 기재
private enum Modifire: String, CaseIterable {
    case none, bold, frame, background
    
    var code: String {
        switch self {
        case .none: return ""
        case .bold: return "\n\t.bold()"
        case .frame: return "\n\t.frame(width: 200, height: 100)"
        case .background: return "\n\t.background(Color.red)"
        }
    }
    
    var description: String {
        switch self {
        case .none: return ""
        case .bold: return "\n\tbold : 글씨 두껍게"
        case .frame: return "\n\tframe : 뷰의 크기 설정"
        case .background: return "\n\tbackground : 배경 스타일 설정"
        }
    }
}

/// Code의 소스를 출력하기 위한 구조체
private struct CodeSource {
    var original:String = "Text(\"TEST\")"
    var text:[String] = Array(repeating: "", count: pickerCnt)
    var toString: String {
        print("CodeSource - \(text)") // 로그
        return original + text.joined()
    }
}

/// Code의 설명을 출력하기 위한 구조체
private struct CodeDescription {
    var original:String = "텍스트 뷰 : 텍스트를 출력해주는 뷰"
    var text:[String] = Array(repeating: "", count: pickerCnt)
    var toString: String {
        print("CodeDescription - \(text)") // 록
        return original + text.joined()
    }
}

/// picker의 개수 (개수에 맞춰 설정 필수)
private let pickerCnt = 3

struct TemplateDetailView: View {
    /// Picker의 제목 배열
    private let pickerTitle: [String] = [
        "First", "Second", "Third",
    ]
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: pickerCnt)
    
    /// 코드의 소스 구조체
    @State private var codeSource = CodeSource()
    
    /// 코드의 설명문 구조체
    @State private var codeDescription = CodeDescription()
    
    var body: some View {
        VStack {
            // # Picker 리스트
            // ForEach : Modifire 순회 & Picker의 Content 생성
            // OnChange : Picker 선택시, 해당 위치의 값 수정
            List {
                
                Picker(
                    pickerTitle[0],
                    selection: $selectedModifire[0]
                ) {
                    ForEach(Modifire.allCases,id: \.self) {
                        modi in
                        Text("\(modi.rawValue)").tag(modi)
                    }
                }.onChange(
                    of: selectedModifire
                ) {
                    old, new in
                    codeSource.text[0] = new[0].code
                    codeDescription.text[0] = new[0].code
                }
                
                Picker(
                    pickerTitle[1],
                    selection: $selectedModifire[1]
                ) {
                    ForEach(Modifire.allCases, id: \.self) {
                        modi in
                        Text("\(modi.rawValue)").tag(modi)
                    }
                }.onChange(
                    of: selectedModifire
                ) {
                    old, new in
                    codeSource.text[1] = new[1].code
                    codeDescription.text[1] = new[1].code
                }
                
                Picker(
                    pickerTitle[2],
                    selection: $selectedModifire[2]
                ) {
                    ForEach(Modifire.allCases, id: \.self) {
                        modi in
                        Text("\(modi.rawValue)").tag(modi)
                    }
                }.onChange(
                    of: selectedModifire
                ) {
                    old, new in
                    codeSource.text[2] = new[2].code
                    codeDescription.text[2] = new[2].code
                }
                
            }.frame(height: 200)
            
            
            // # 코드 텍스트
            VStack(alignment: .leading) {
                CodeEditor(
                    source: codeSource.toString,
                    language: .swift,
                    theme: .agate
                ).frame(width: 350, height: 100)
                CodeText(codeSource.toString)
            }
            .frame(width: 350, height: 200)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            Spacer()
            
            // # 코드 설명
            VStack(alignment: .leading) {
                CodeEditor(
                    source: codeDescription.toString,
                    language: .swift,
                    theme: .agate
                )
            }
            .frame(width: 350)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            Spacer()
            
            // # 코드 결과
            Text("TEST")
                .font(.largeTitle)
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
            
            Spacer()
        }
    }
}

/// 코드 결과 - 부여할 모디파이어 설정
private struct ModifireBuilder: ViewModifier {
    @Binding var selectedModifire: Modifire
    
    func body(content: Content) -> some View {
        switch selectedModifire {
        case .none : content
        case .bold : content.bold()
        case .frame : content.frame(width: 200, height: 100)
        case .background : content.background(Color.red)
        }
    }
}

#Preview {
    TemplateDetailView()
}
