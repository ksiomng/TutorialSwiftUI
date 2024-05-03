//
//  TextEditorView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/2/24.
//

import SwiftUI

private let pickerCount = 9

private struct CodeSource {
    
    var original:String = """
    TextEditor(text: $text)
        .frame(height: 100)
"""
    var text:[String] = Array(repeating: "", count: pickerCount)
    
    var toString: String {
        //print("CodeSource - \(text)")
        return original + text.joined()
    }
}
private struct CodeDescription {
    var original: String = "TextEditor View : 텍스트 입력하는 뷰"
    var text:[String] = Array(repeating: "", count: pickerCount)

    var toString: String {
        //print("CodeDescription - \(text)")
        return original + text.joined()
    
    }
}
/// 사용할 모디파이어 기재
private enum Modifire: String, CaseIterable {
    case none
    case padding
    case font
    case foregroundColor
    case multilineTextAlignment
    case lineSpacing
    case textContentType
    case autocapitalization
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .padding:
            return "\npadding : 입력 필드 주위에 여백 추가"
        case .font:
            return "\nfont : 입력 필드의 글꼴과 크기 설정"
        case .foregroundColor:
            return "\nforegroundColor : 입력 필드의 색상 설정"
        case .multilineTextAlignment:
            return "\nmultilineTextAlignment : 여러 줄 텍스트 정렬"
        case .lineSpacing:
            return "\nlineSpacing : 텍스트의 줄 간격 설정"
        case .textContentType:
            return "\ntextContentType : 입력 필드의 콘텐츠 유형 지정"
        case .autocapitalization:
            return "\nautocapitalization : 자동 대문자화 옵션 설정"
        }
    }
    var code: String {
        switch self {
        case .none:
            return ""
        case .padding:
            return "\n\t.padding()"
        case .font:
            return "\n\t.font(.largeTitle)"
        case .foregroundColor:
            return "\n\t.foregroundColor(.blue)"
        case .multilineTextAlignment:
            return "\n\t.multilineTextAlignment(.trailing)"
        case .lineSpacing:
            return "\n\t.lineSpacing(10)"
        case .textContentType:
            return "\n\t.textContentType(.none)"
        case .autocapitalization:
            return "\n\t.autocapitalization(.sentences)"
        }
    }
}

struct TextEditorView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 11)
    @State private var text: String = ""
    @State private var codeSource = CodeSource()
    @State private var codeDescription = CodeDescription()
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20){
                //코드 결과
                viewPreviewSection
                
                // List Picker - 위치별 모디파이어 선택
                HStack {
                    Text ("Modifer 1")
                    
                    Spacer()
                    
                    Picker("Modifier 1", selection: $selectedModifire[0]) {
                        ForEach(Modifire.allCases, id: \.self) { modi in
                            Text("\(modi.rawValue)")
                                .tag(modi)
                        }
                    }
                    .onChange(of: selectedModifire) { oldValue, newValue in
                        codeSource.text[0] = newValue[0].code
                        codeDescription.text[0] = newValue[0].description
                    }
                }
                HStack {
                    Text ("Modifer 2")
                    
                    Spacer()
                    
                    Picker("Modifier 2", selection: $selectedModifire[1]) {
                        ForEach(Modifire.allCases, id: \.self) { modi in
                            Text("\(modi.rawValue)")
                                .tag(modi)
                        }
                    }
                    .onChange(of: selectedModifire) { oldValue, newValue in
                        codeSource.text[1] = newValue[1].code
                        codeDescription.text[1] = newValue[1].description
                    }
                }
                HStack {
                    Text ("Modifer 3")
                    
                    Spacer()
                    
                    Picker("Modifier 3", selection: $selectedModifire[2]) {
                        ForEach(Modifire.allCases, id: \.self) { modi in
                            Text("\(modi.rawValue)")
                                .tag(modi)
                        }
                    }
                    .onChange(of: selectedModifire) { oldValue, newValue in
                        codeSource.text[2] = newValue[2].code
                        codeDescription.text[2] = newValue[2].description
                    }
                }
                HStack {
                    Text ("Modifer 4")
                    
                    Spacer()
                    
                    Picker("Modifier 4", selection: $selectedModifire[3]) {
                        ForEach(Modifire.allCases, id: \.self) { modi in
                            Text("\(modi.rawValue)")
                                .tag(modi)
                        }
                    }
                    .onChange(of: selectedModifire) { oldValue, newValue in
                        codeSource.text[3] = newValue[3].code
                        codeDescription.text[3] = newValue[3].description
                    }
                }
                .frame(maxWidth: .infinity)
                
                codePreviewSection
                
              .cornerRadius(8)
                
            }
            .padding()
            .frame(maxHeight: .infinity) // 내부 VStack의 세로 크기를 최대화
            .navigationTitle("TextEditor")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            TitleTextView(title: "View Preview")
            
            Text("TextEditor")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            VStack {
                TextEditor(text: $text)
                    .frame(height: 100)
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
                //Divider()
                Spacer()
                Text("\(text)")
                    .padding()
                    .foregroundColor(.black)
                    .font(.body)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    private var codePreviewSection: some View {
        VStack(spacing:20) {
            TitleTextView(title: "Code Preview")
            CodePreviewView(code: returnCode(), copyAction: copyCode, showCopy: true)
            
            TitleTextView(title: "Description")
            CodePreviewView(code: basecode(), copyAction: copyCode, showCopy: false)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    func basecode() -> String {
        return codeDescription.toString
    }
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
    func returnCode() -> String {
        return codeSource.toString
    }
}

/// 코드 결과 - 부여할 모디파이어 설정
private struct ModifireBuilder: ViewModifier {
    @Binding var selectedModifire: Modifire
    
    func body(content: Content) -> some View {
        switch selectedModifire {
        case .none : content
        case .padding: content.padding()
        case .font: content.font(.largeTitle)
        case .foregroundColor: content.foregroundColor(.blue)
        case .multilineTextAlignment: content.multilineTextAlignment(.trailing)
        case .lineSpacing: content.lineSpacing(10)
        case .textContentType: content.textContentType(.none)
        case .autocapitalization: content.autocapitalization(.sentences)
        }
    }
}


#Preview {
    TextEditorView()
}
