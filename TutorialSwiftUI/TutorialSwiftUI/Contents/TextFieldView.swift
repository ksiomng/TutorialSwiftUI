//
//  TextFieldView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/1/24.
//

import SwiftUI

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
    case autocorrection
}

struct TextFieldView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 11)
    @State private var text: String = ""
    var body: some View {
        VStack {
            Spacer()
            // 코드 결과
            TextField("Enter text here", text: $text)
                .font(.largeTitle)
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
            Text("\(text)")
                .padding()
                .foregroundColor(.black)
                .font(.body)
            Spacer()
            
            
            // 코드 텍스트
            VStack(alignment: .leading) {
                Text("TextField(\"Enter text here\", text: $text)")
                CodeBuilder(selectedModifire: $selectedModifire[0])
                CodeBuilder(selectedModifire: $selectedModifire[1])
                CodeBuilder(selectedModifire: $selectedModifire[2])
                CodeBuilder(selectedModifire: $selectedModifire[3])
            }
            .frame(width: 350)
            .font(.system(size: 18, design: .monospaced))
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            Spacer()
            
            // 코드 설명
            VStack(alignment: .leading) {
                Text("TextField View : 텍스트 입력하는 뷰")
                DescriptionBuilder(selectedModifire: $selectedModifire[0])
                DescriptionBuilder(selectedModifire: $selectedModifire[1])
                DescriptionBuilder(selectedModifire: $selectedModifire[2])
                DescriptionBuilder(selectedModifire: $selectedModifire[3])
            }
            .frame(width: 350)
            .font(.system(size: 20, design: .monospaced))
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            Spacer()
            // List Picker - 위치별 모디파이어 선택
            List {
                Picker("First", selection: $selectedModifire[0]) {
                    ForEach(Modifire.allCases, id: \.self) { modi in
                        Text("\(modi.rawValue)")
                            .tag(modi)
                    }
                }
                Picker("Second", selection: $selectedModifire[1]) {
                    ForEach(Modifire.allCases, id: \.self) { modi in
                        Text("\(modi.rawValue)")
                            .tag(modi)
                    }
                }
                Picker("Third", selection: $selectedModifire[2]) {
                    ForEach(Modifire.allCases, id: \.self) { modi in
                        Text("\(modi.rawValue)")
                            .tag(modi)
                    }
                }
                Picker("Fourth", selection: $selectedModifire[3]) {
                    ForEach(Modifire.allCases, id: \.self) { modi in
                        Text("\(modi.rawValue)")
                            .tag(modi)
                    }
                }
            }.frame(height: 250)
        }
    }
}

/// 코드 텍스트 - 출력할 코드 설정
private struct CodeBuilder: View {
    @Binding var selectedModifire: Modifire
    
    var body: some View {
        switch selectedModifire {
        case .none:
            return Text("")
        case .padding:
            return Text("\t.padding()")
        case .background:
            return Text("\t.background(Color.gray.opacity(0.1))")
        case .font:
            return Text("\t.font(.body)")
        case .foregroundColor:
            return Text("\t.foregroundColor(.blue)")
        case .multilineTextAlignment:
            return Text("\t.multilineTextAlignment(.leading)")
        case .textContentType:
            return Text("\t.textContentType(.none)")
        case .autocapitalization:
            return Text("\t.autocapitalization(.words)")
        case .autocorrection:
            return Text("\t.disableAutocorrection(true)")
        }
    }
}

/// 코드 설명 - 출력할 설명 설정
private struct DescriptionBuilder: View {
    @Binding var selectedModifire: Modifire
    
    var body: some View {
        switch selectedModifire {
        case .none:
            return Text("")
        case .padding:
            return Text("padding : 입력 필드 주위에 여백 추가")
        case .background:
            return Text("background : 입력 필드의 배경 색상 또는 이미지 추가")
        case .font:
            return Text("font : 입력 필드의 글꼴과 크기 설정")
        case .foregroundColor:
            return Text("foregroundColor : 입력 필드의 색상 설정")
        case .multilineTextAlignment:
            return Text("multilineTextAlignment : 여러 줄 텍스트 정렬")
        case .textContentType:
            return Text("textContentType : 입력 필드의 콘탠츠 유형 지정")
        case .autocapitalization:
            return Text("autocapitalization : 자동 대문자화 옵션 설정")
        case .autocorrection:
            return Text("autocorrection : 자동 수정 옵션 설정")
        }
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
        case .font: content.font(.body)
        case .foregroundColor: content.foregroundColor(.black)
        case .multilineTextAlignment: content.multilineTextAlignment(.leading)
        case .textContentType: content.textContentType(.none)
        case .autocapitalization: content.autocapitalization(.words)
        case .autocorrection: content.disableAutocorrection(true)
        }
    }
}

#Preview {
    TextFieldView()
}
