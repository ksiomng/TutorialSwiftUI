/*
 HighlightSwift : https://github.com/appstefan/highlightswift.git
 CodeEditor : https://github.com/ZeeZide/CodeEditor.git
*/

import SwiftUI
import HighlightSwift
import CodeEditor

/// 사용할 모디파이어 기재
private enum Modifire: String, CaseIterable {
    case none, bold, frame, background, padding, foregroundColor
    
    /// 코드 소스
    var code: String {
        switch self {
        case .none: return ""
        case .bold: return "\n\t.bold()"
        case .frame: return "\nframe(width: 300, height: 300)"
        case .background: return "\n\t.background(Color.red)"
        case .padding: return "\n\tpadding"
        case .foregroundColor: return "\n.foregroundColor(.primary)"
        }
    }
    
    /// 코드 설명
    var description: String {
        switch self {
        case .none: return ""
        case .bold: return "\n\tbold : 글씨 두껍게"
        case .frame: return "\n\tframe : 뷰의 크기 설정"
        case .background: return "\n\tbackground : 배경 스타일 설정"
        case .padding: return "\n\tpadding"
        case .foregroundColor: return "\n\t.foregroundColor: 글자색 지정"
        }
    }
}

/// Code의 소스를 출력하기 위한 구조체
private struct CodeSource {
    /// 기본 대상
    var original:String = """
VStack {
    Text(\"Text 01\")
        .border(Color.black)
    Text(\"Text 01\")
        .border(Color.black)
    Text(\"Text 01\")
        .border(Color.black)
}
"""
    
    /// 모디파이어 텍스트
    var text:[String] = Array(repeating: "", count: pickerCount)
    
    /// original과 text 배열을 연결한 문자열
    var toString: String {
        print("CodeSource - \(text)") // 로그
        return original + text.joined()
    }
}

/// Code의 설명을 출력하기 위한 구조체
private struct CodeDescription {
    /// 기본 대상
    var original:String = "VStack : 내부의 View들을 수직(세로)으로 배치"
    
    /// 모디파이어 텍스트
    var text:[String] = Array(repeating: "", count: pickerCount)
    
    /// original과 text 배열을 연결한 문자열
    var toString: String {
        print("CodeDescription - \(text)") // 로그
        return original + text.joined()
    }
}

/// - picker의 개수 (개수에 맞춰 설정 필수)
/// - CodeSource, CodeDescription 및 selectedModifire의 repeating에 사용
private let pickerCount = 5

/// # 팀 공유용 상세뷰 템플릿
struct VStackView: View {
    /// Picker의 제목 배열
    private let pickerTitle: [String] = [
        "First", "Second", "Third", "fourth", "fifth"
    ]
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: pickerCount)
    
    /// 코드의 소스 구조체
    @State private var codeSource = CodeSource()
    
    /// 코드의 설명문 구조체
    @State private var codeDescription = CodeDescription()

    /// # 리스트용 PickerView
    /// - 설명
    ///     - ForEach : Enum 타입의 Modifire순회 & Picker의 Content 생성
    ///     - OnChange : Picker 선택시, 해당 위치의 값 수정
    /// - 인자
    ///     - i : index
    private func PickerView(_ i: Int) -> some View {
        return Picker(
            pickerTitle[i],
            selection: $selectedModifire[i]
        ) {
            ForEach(Modifire.allCases,id: \.self) {
                modi in
                Text("\(modi.rawValue)").tag(modi)
            }
        }.onChange(
            of: selectedModifire
        ) {
            old, new in
            codeSource.text[i] = new[i].code
            codeDescription.text[i] = new[i].code
        }
    }
    
    /// # body
    var body: some View {
        VStack {
            /// ## Picker 리스트
            List {
                PickerView(0)
                PickerView(1)
                PickerView(2)
                PickerView(3)
                PickerView(4)
            }
            .frame(maxHeight: 230)
            .listStyle(PlainListStyle())
            
            Spacer()
            
            /// ## 코드 소스
            VStack(alignment: .leading) {
                CodeEditor(
                    source: codeSource.toString,
                    language: .javascript,
                    theme: .agate
                ).frame(width: 350, height: 200)
            }
            .cornerRadius(10)
            
            Spacer()
            
            /// ## 코드 설명
            VStack(alignment: .leading) {
                CodeEditor(
                    source: codeDescription.toString,
                    language: .swift,
                    theme: .agate
                ).frame(width: 350, height: 100)
            }
            .cornerRadius(10)
            
            Spacer()
            
            /// ## 코드 결과
            VStack() {
                Text("Text 01").border(Color.black)
                Text("Text 02").border(Color.black)
                Text("Text 03").border(Color.black)
            }
            .font(.largeTitle)
            .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
            .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
            .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
            .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
            .modifier(ModifireBuilder(selectedModifire: $selectedModifire[4]))
            
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
        case .frame : content.frame(width: 300, height: 300)
        case .background : content.background(Color.red)
        case .padding : content.padding(20)
        case .foregroundColor : content.foregroundColor(.blue)
        }
    }
}

#Preview {
    VStackView()
}
