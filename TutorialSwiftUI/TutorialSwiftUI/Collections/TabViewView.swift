/*
 HighlightSwift : https://github.com/appstefan/highlightswift.git
 CodeEditor : https://github.com/ZeeZide/CodeEditor.git
 */

import SwiftUI
import HighlightSwift
import CodeEditor

/// Code의 소스를 출력하기 위한 구조체
private struct CodeSource {
    /// 기본 대상
    var original:String = """
TabView {
    Text("House")
        .tabItem {
            Image(systemName: "house")
            Text("House")
        }
    Text("Person")
        .tabItem {
            Image(systemName: "person")
            Text("Person")
        }
    Text("Bag")
        .badge(5)
        .tabItem {
            Image(systemName: "bag")
            Text("Bag")
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
TabView : 한 화면에서 여러 개의 View를 탭 방식으로 전환
tabItem : 각 탭에 표시할 탭 아이템을 정의
badge : 탭 아이템에 특정 숫자의 뱃지 표시
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
    case none, accentColor, tabViewStyle
    
    /// 코드 설명
    var description: String {
        switch self {
        case .none: return ""
        case .accentColor: return "\naccentColor : 아이템의 강조 색상 변경"
        case .tabViewStyle: return "\ntabViewStyle : 탭 아이콘 대신에 스와이프 제스처로 페이지 전환"
        }
    }
    
    /// 코드 소스
    var code: String {
        switch self {
        case .none: return ""
        case .accentColor: return "\n.accentColor(.red)"
        case .tabViewStyle: return "\n.tabViewStyle(.page)"
        }
    }
}

/// 코드 결과 - 부여할 모디파이어 설정
private struct ModifireBuilder: ViewModifier {
    @Binding var selectedModifire: Modifire
    
    func body(content: Content) -> some View {
        switch selectedModifire {
        case .none : content
        case .accentColor : content.accentColor(.red)
        case .tabViewStyle : content.tabViewStyle(.page)
        }
    }
}

/// - picker의 개수 (개수에 맞춰 설정 필수)
/// - CodeSource, CodeDescription 및 selectedModifire의 repeating에 사용
private let pickerCount = 1

/// # body View
struct TabViewView: View {
    /// Picker의 제목 배열
    private let pickerTitle: [String] = [
        "First"
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
    
    /// # 영역 - 코드의 실행 결과를 보여줌
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            TitleTextView(title: "View Preview")
            
            Text("Color")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            HStack{
                Spacer()
                TabView {
                    Text("House")
                        .tabItem {
                            Image(systemName: "house")
                            Text("House")
                        }
                    Text("Person")
                        .tabItem {
                            Image(systemName: "person")
                            Text("Person")
                        }
                    Text("Bag")
                        .badge(5)
                        .tabItem {
                            Image(systemName: "bag")
                            Text("Bag")
                        }
                }
                .frame(height: 100)
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))

                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    /// # 영역 - 코드의 프리뷰를 보여줌
    private var codePreviewSection: some View {
        VStack(spacing: 20) {
            TitleTextView(title: "Code Preview")
            CodePreviewView(code: returnCode(), copyAction: copyCode, showCopy: true)
            
            TitleTextView(title: "Code Descrption")
            CodePreviewView(code: basecode(), copyAction: copyCode, showCopy: false)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    /// Base code
    func basecode() -> String {
        return codeDescription.toString
    }
    
    ///
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
    
    ///
    func returnCode() -> String {
        return codeSource.toString
    }
    
    /// # 영역 - 옵션, 모디파이어 선택
    private var optionSelectSection: some View {
        VStack {
            TitleTextView(title: "Option Select")
            Section(header: Text("Modifire")) {
                PickerView(0)
            }
        }.padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
    
    /// # body
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                viewPreviewSection
                optionSelectSection
                codePreviewSection
            }
            .padding()
            .frame(maxHeight: .infinity)
            .navigationTitle("TabView View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TabViewView()
}
