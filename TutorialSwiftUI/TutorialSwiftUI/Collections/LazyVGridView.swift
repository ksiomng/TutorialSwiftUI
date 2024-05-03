/*
 HighlightSwift : https://github.com/appstefan/highlightswift.git
 CodeEditor : https://github.com/ZeeZide/CodeEditor.git
 */

import SwiftUI
import HighlightSwift
import CodeEditor

/// Picker에서 사용할 속성, Grid 칼럼을 나누는 개수
private enum GridItems: String, CaseIterable  {
    case fixed1, fixed2, fixed3,
         flexible1, flexible2, flexible3,
         adaptive1, adaptive2, adaptive3
    
    func toGridItem() -> [GridItem] {
        switch self {
        case .fixed1:
            return [
                GridItem(.fixed(100)),
            ]
        case .fixed2:
            return [
                GridItem(.fixed(100)),
                GridItem(.fixed(100)),
            ]
        case .fixed3:
            return [
                GridItem(.fixed(100)),
                GridItem(.fixed(100)),
                GridItem(.fixed(100)),
            ]
        case .flexible1:
            return [
                GridItem(.flexible()),
            ]
        case .flexible2:
            return [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]
        case .flexible3:
            return [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]
        case .adaptive1:
            return [
                GridItem(.adaptive(minimum: 100)),
            ]
        case .adaptive2:
            return [
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100)),
            ]
        case .adaptive3:
            return [
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100)),
            ]
        }
    }
    
    func toString() -> String {
        switch self {
        case .fixed1:
            return "[GridItem(.fixed(100)),]"
        case .fixed2:
            return """
[
                GridItem(.fixed(100)),
                GridItem(.fixed(100)),
            ]
"""
        case .fixed3:
            return """
[
                GridItem(.fixed(100)),
                GridItem(.fixed(100)),
                GridItem(.fixed(100)),
            ]
"""
        case .flexible1:
            return "[GridItem(.flexible()),]"
        case .flexible2:
            return """
[
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]
"""
        case .flexible3:
            return """
[
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]
"""
        case .adaptive1:
            return "[GridItem(.adaptive(minimum: 100)),]"
        case .adaptive2:
            return """
[
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100)),
            ]
"""
        case .adaptive3:
            return """
[
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100)),
            ]
"""
        }
    }
}


/// Picker에서 사용할 속성, VStack의 Alignment 속성
private enum AlignmentLazyVGrid: String, CaseIterable  {
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
private enum SpacingLazyVGrid: String, CaseIterable {
    case none = "nil", five = "5", ten = "10", twenty = "20"
    
    func toCGFloat() -> CGFloat? {
        switch self {
        case .none:
            return nil
        case .five:
            return 5
        case .ten:
            return 10
        case .twenty:
            return 20
        }
    }
}

/// Code의 소스를 출력하기 위한 구조체
private struct CodeSource {
    /// 기본 대상
    var original:String = """
ScrollView(.vertical) {
    LazyVGrid(columns: [GridItem(.fixed(100)),],
              alignment: .center,
              spacing: nil
    ) {
        ForEach((1...999), id: \\.self) {
            Text("<Item\\($0)>")
                .frame(width:100, height: 40)
                .border(Color.black)
        }
    }
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
LazyVGrid : 내부의 View들을 수직(세로)으로 배치
Alignment : 내부의 View들을 정렬
Spacing : 내부의 View들 사이의 간격을 조정
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
        case .bold: return "\nbold : LazyVGrid 내부 View들의 글씨를 두껍게"
        case .frame: return "\nframe : LazyVGrid의 크기 설정"
        case .background: return "\nbackground : LazyVGrid의 배경 스타일 설정"
        case .padding: return "\npadding : LazyVGrid의 안쪽에 여백 설정"
        case .foregroundColor: return "\nforegroundColor: LazyVGrid 내부 View들의 글자색 지정"
        }
    }
    
    /// 코드 소스
    var code: String {
        switch self {
        case .none: return ""
        case .bold: return "\n.bold()"
        case .frame: return "\n.frame(width: 200, height: 100)"
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
        case .frame : content.frame(width: 200, height: 100)
        case .background : content.background(Color.red)
        case .padding : content.padding(20)
        case .foregroundColor : content.foregroundColor(.blue)
        }
    }
}

/// - picker의 개수 (개수에 맞춰 설정 필수)
/// - CodeSource, CodeDescription 및 selectedModifire의 repeating에 사용
private let pickerCount = 3

/// # body View
struct LazyVGridView: View {
    /// Picker의 제목 배열
    private let pickerTitle: [String] = [
        "First", "Second", "Third"
    ]
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: pickerCount)
    
    /// Picker에서 선택될 VStack의 Alignment 속성
    @State private var selectedGridItem: GridItems = .fixed1
    
    /// Picker에서 선택될 VStack의 Alignment 속성
    @State private var selectedAlignment: AlignmentLazyVGrid = .center
    
    /// Picker에서 선택될 VStack의 Spacing 속성
    @State private var selectedSpacing: SpacingLazyVGrid = .none
    
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
        return HStack {
            Text(pickerTitle[i])
            Spacer()
            Picker(
                pickerTitle[i],
                selection: $selectedModifire[i]
            ) {
                ForEach(
                    Modifire.allCases,
                    id: \.self
                ) {
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
    }
    
    
    /// # 리스트용 PickerView
    /// - Grid의 columns 설정
    private func PickerGridItemView() -> some View {
        return HStack {
            Text("Columns")
            Spacer()
            Picker(
                "Columns",
                selection: $selectedGridItem
            ) {
                ForEach(
                    GridItems.allCases,
                    id: \.self
                ) {
                    item in
                    Text("\(item.rawValue)").tag(item)
                }
            }.onChange(
                of: selectedGridItem
            ) {
                old, new in
                codeSource.original = codeSource.original
                    .replacingOccurrences(
                        of: "columns: \(old.toString())",
                        with: "columns: \(new.toString())"
                    )
            }
        }
    }
    
    /// # 리스트용 PickerView
    /// - VStack의 Alignment 설정
    private func PickerAlignmentView() -> some View {
        return HStack {
            Text("Alignment")
            Spacer()
            Picker(
                "Alignment",
                selection: $selectedAlignment
            ) {
                ForEach(
                    AlignmentLazyVGrid.allCases,
                    id: \.self
                ) {
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
                        with: "alignment: .\(new.rawValue)"
                    )
            }
        }
    }
    
    
    /// # 리스트용 PickerView
    /// - VStack의 Spacing 설정
    private func PickerSpacingView() -> some View {
        return HStack {
            Text("Spacing")
            Spacer()
            Picker(
                "Spacing",
                selection: $selectedSpacing
            ) {
                ForEach(SpacingLazyVGrid.allCases,id: \.self) {
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
    }
    
    /// # body
    var body: some View {
        VStack {
            
            /// ## Picker 리스트
            VStack {
                Section(header: Text("Option")) {
                    PickerGridItemView()
                    PickerAlignmentView()
                    PickerSpacingView()
                }
                
                Section(header: Text("Modifire")) {
                    PickerView(0)
                    PickerView(1)
                    PickerView(2)
                }
            }.padding(25)
            
            /// ## 코드 설명, 코드 소스
            VStack {
                CodeEditor(
                    source: codeDescription.toString,
                    language: .swift,
                    theme: .agate
                ).frame(width: 350, height: 100)
                
                CodeEditor(
                    source: codeSource.toString,
                    language: .javascript,
                    theme: .agate
                ).frame(width: 350, height: 150)
                
                /// ## 코드 결과
                
                ScrollView(.vertical) {
                    LazyVGrid(columns:
                                selectedGridItem.toGridItem(),
                              alignment: selectedAlignment.toAlignment(),
                              spacing: selectedSpacing.toCGFloat()
                    ) {
                        ForEach((1...999), id: \.self) {
                            Text("<Item\($0)>")
                                .frame(width:100, height: 40)
                                .border(Color.black)
                        }
                    }
                }
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
            }
            .cornerRadius(10)
            
            Spacer()
        }
    }
}

#Preview {
    LazyVGridView()
}
