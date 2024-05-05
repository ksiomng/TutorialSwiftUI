//
//  TextFieldView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/1/24.
//

import SwiftUI

private let pickerCount = 4

private struct CodeSource {

    var original:String = "TextField(\"Enter text here\", text: $text)"
    var text:[String] = Array(repeating: "", count: pickerCount)
    
    var toString: String {
        //print("CodeSource - \(text)")
        return original + text.joined()
    }
}
private struct CodeDescription {
    var original: String = "TextField View : 텍스트 입력하는 뷰"
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
    case background
    case font
    case foregroundColor
    case multilineTextAlignment
    case textContentType
    case autocapitalization
    case disableAutocorrection
    
    var code: String {
        switch self {
        case .none:
            return ""
        case .padding:
            return "\n\t.padding()"
        case .background:
            return "\n\t.background(Color.blue.opacity(0.1))"
        case .font:
            return "\n\t.font(.largeTitle)"
        case .foregroundColor:
            return "\n\t.foregroundColor(.blue)"
        case .multilineTextAlignment:
            return "\n\t.multilineTextAlignment(.trailing)"
        case .textContentType:
            return "\n\t.textContentType(.none)"
        case .autocapitalization:
            return "\n\t.autocapitalization(.sentences)"
        case .disableAutocorrection:
            return "\n\t.disableAutocorrection(true)"
        }
    }
    var description: String {
        switch self {
        case .none:
            return ""
        case .padding:
            return "\npadding : 입력 필드 주위에 여백 추가"
        case .background:
            return "\nbackground : 입력 필드의 배경 색상 또는 이미지 추가"
        case .font:
            return "\nfont : 입력 필드의 글꼴과 크기 설정"
        case .foregroundColor:
            return "\nforegroundColor : 입력 필드의 색상 설정"
        case .multilineTextAlignment:
            return "\nmultilineTextAlignment : 여러 줄 텍스트 정렬"
        case .textContentType:
            return "\ntextContentType : 입력 필드의 콘텐츠 유형 지정"
        case .autocapitalization:
            return "\nautocapitalization : 자동 대문자화 옵션 설정"
        case .disableAutocorrection:
            return "\ndisableAutocorrection : 자동 수정 비활성화"
        }
    }
}

struct TextFieldView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 11)
    @State private var text: String = ""
    @State private var codeSource = CodeSource()
    @State private var codeDescription = CodeDescription()
    
    var body: some View {
        ScrollView{
            VStack (spacing: 20){
                // 코드 결과
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
                .padding(.horizontal)
                
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
                .padding(.horizontal)
                
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
                .padding(.horizontal)
                
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
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                
                codePreviewSection
                
            }
            .padding()
            .frame(maxHeight: .infinity) // 내부 VStack의 세로 크기를 최대화
            .navigationTitle("TextField")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            TitleTextView(title: "View Preview")
            
            Text("TextField")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            VStack {
                Spacer()
                TextField("Enter text here", text: $text)
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
                Divider()
                
                Text("\(text)")
                    .padding()
                    .foregroundColor(.black)
                    .font(.body)
                Spacer()
            }
            Spacer()
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
        case .background: content.background(Color.blue.opacity(0.1))
        case .font: content.font(.largeTitle)
        case .foregroundColor: content.foregroundColor(.blue)
        case .multilineTextAlignment: content.multilineTextAlignment(.trailing)
        case .textContentType: content.textContentType(.none)
        case .autocapitalization: content.autocapitalization(.sentences)
        case .disableAutocorrection: content.disableAutocorrection(true)
        }
    }
}

#Preview {
    TextFieldView()
}
