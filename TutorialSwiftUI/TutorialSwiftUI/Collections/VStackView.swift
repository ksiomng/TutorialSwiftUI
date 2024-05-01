/*
 HighlightSwift : https://github.com/appstefan/highlightswift.git
 CodeEditor : https://github.com/ZeeZide/CodeEditor.git
 */

import SwiftUI
import HighlightSwift
import CodeEditor

/// Picker에서 사용할 속성, VStack의 Alignment 속성
private enum AlignmentVStack: String, CaseIterable  {
    case center, leading, trailing
    
    func toAlignment() -> HorizontalAlignment {
        switch self {
        case .center:
            return .center
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

/// Picker에서 사용할 속성, VStack의 Spacing 속성
private enum SpacingVStack: String, CaseIterable {
    case none = "nil", one = "1", five = "5", ten = "10"
    
    func toCGFloat() -> CGFloat? {
        switch self {
        case .none:
            return nil
        case .one:
            return 1
        case .five:
            return 5
        case .ten:
            return 10
        }
    }
}

/// Code의 소스를 출력하기 위한 구조체
private struct CodeSource {
    /// 기본 대상
    var original:String = """
VStack (alignment: .center,spacing: nil){
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
    var original:String = """
VStack : 내부의 View들을 수직(세로)으로 배치
Alignment : 내부의 View들을 정렬
Spacing : 내부의 View들의 간격을 조정
"""
    
    /// 모디파이어 텍스트
    var text:[String] = Array(repeating: "", count: pickerCount)
    
    /// original과 text 배열을 연결한 문자열
    var toString: String {
        print("CodeDescription - \(text)") // 로그
        return original + text.joined()
    }
}

/// 사용할 모디파이어 기재
private enum Modifire: String, CaseIterable {
    case none, bold, frame, background, padding, foregroundColor
    
    /// 코드 설명
    var description: String {
        switch self {
        case .none: return ""
        case .bold: return "\nbold : 글씨 두껍게"
        case .frame: return "\nframe : 뷰의 크기 설정"
        case .background: return "\nbackground : 배경 스타일 설정"
        case .padding: return "\npadding : 내부에 여백 설정"
        case .foregroundColor: return "\nforegroundColor: 글자색 지정"
        }
    }
    
    /// 코드 소스
    var code: String {
        switch self {
        case .none: return ""
        case .bold: return "\n.bold()"
        case .frame: return "\n.frame(width: 200, height: 150)"
        case .background: return "\n.background(Color.red)"
        case .padding: return "\n.padding(20)"
        case .foregroundColor: return "\n.foregroundColor(.blue)"
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
        case .frame : content.frame(width: 200, height: 150)
        case .background : content.background(Color.red)
        case .padding : content.padding(20)
        case .foregroundColor : content.foregroundColor(.blue)
        }
    }
}

/// - picker의 개수 (개수에 맞춰 설정 필수)
/// - CodeSource, CodeDescription 및 selectedModifire의 repeating에 사용
private let pickerCount = 5

/// # body View
struct VStackView: View {
    /// Picker의 제목 배열
    private let pickerTitle: [String] = [
        "First", "Second", "Third", "Fourth", "Fifth"
    ]
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: pickerCount)
    
    /// Picker에서 선택될 VStack의 Alignment 속성
    @State private var selectedAlignment: AlignmentVStack = .center
    
    /// Picker에서 선택될 VStack의 Spacing 속성
    @State private var selectedSpacing: SpacingVStack = .none
    
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
                item in
                Text("\(item.rawValue)").tag(item)
            }
        }.onChange(
            of: selectedModifire
        ) {
            old, new in
            codeSource.text[i] = new[i].code
            codeDescription.text[i] = new[i].description
        }
    }
    
    /// # 리스트용 PickerView
    /// - VStack의 Alignment 설정
    private func PickerAlignmentView() -> some View {
        return Picker(
            "Alignment",
            selection: $selectedAlignment
        ) {
            ForEach(AlignmentVStack.allCases,id: \.self) {
                item in
                Text("\(item.rawValue)").tag(item)
            }
        }.onChange(
            of: selectedAlignment
        ) {
            old, new in
            codeSource.original = codeSource.original
                .replacingOccurrences(
                    of: "alignment: .\(old.rawValue)",
                    with: "alignment: .\(new.rawValue)")
        }
    }
    
    /// # 리스트용 PickerView
    /// - VStack의 Spacing 설정
    private func PickerSpacingView() -> some View {
        return Picker(
            "Spacing",
            selection: $selectedSpacing
        ) {
            ForEach(SpacingVStack.allCases,id: \.self) {
                item in
                Text("\(item.rawValue)").tag(item)
            }
        }.onChange(
            of: selectedSpacing
        ) {
            old, new in
            codeSource.original = codeSource.original
                .replacingOccurrences(
                    of: "spacing: \(old.rawValue)",
                    with: "spacing: \(new.rawValue)")
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
            
            Divider()
            
            List {
                PickerAlignmentView()
                PickerSpacingView()
            }
            .frame(maxHeight: 230)
            .listStyle(PlainListStyle())
            
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
            
            /// ## 코드 결과
            VStack(
                alignment: selectedAlignment.toAlignment(),
                spacing: selectedSpacing.toCGFloat()
            ) {
                Text("Hello").border(Color.black)
                Text("AppSchool").border(Color.black)
                Text("Tutorial Project").border(Color.black)
            }
            .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
            .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
            .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
            .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
            .modifier(ModifireBuilder(selectedModifire: $selectedModifire[4]))
            
            Spacer()
        }
    }
}

#Preview {
    VStackView()
}
