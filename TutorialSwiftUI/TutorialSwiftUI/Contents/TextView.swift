//
//  TextView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/1/24.
//

import SwiftUI

private let pickerCount = 4

private struct CodeSource {

    var original:String = "Text(\"Test\")"
    var text:[String] = Array(repeating: "", count: pickerCount)
    
    var toString: String {
        //print("CodeSource - \(text)")
        return original + text.joined()
    }
}
private struct CodeDescription {
    var original: String = "Text View : 텍스트를 출력해주는 뷰"
    var text:[String] = Array(repeating: "", count: pickerCount)

    var toString: String {
        //print("CodeDescription - \(text)")
        return original + text.joined()
    
    }
}


/// 사용할 모디파이어 기재
private enum Modifire: String, CaseIterable {
    case none
    case bold
    case frame
    case background
    case font
    case foregroundColor
    case opacity
    case italic
    case underline
    case rotationEffect
    case shadow
    case fontWeight
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .bold:
            return "\nbold : 텍스트 굵은 글꼴 설정"
        case .frame:
            return "\nframe : 뷰 크기 설정"
        case .background:
            return "\nbackground : 배경 설정"
        case .font:
            return "\nfont : 텍스트의 글꼴과 크기 설정"
        case .foregroundColor:
            return "\nforegroundColor : 텍스트의 글꼴 두께 설정"
        case .opacity:
            return "\nopacity : 텍스트의 불투명도 조절"
        case .italic:
            return "\nitalic : 텍스트의 기울임꼴로 설정"
        case .underline:
            return "\nunderline : 텍스트에 밑줄 추가"
        case .rotationEffect:
            return "\nrotationEffect : 텍스트 회전"
        case .shadow:
            return "\nshadow :  텍스트 그림자 효과 설정"
        case .fontWeight:
            return "\nfontWeight : 텍스트의 글꼴 두께 설정"
        }
    }
    var code: String {
        switch self {
        case .none:
            return ""
        case .bold:
            return "\n\t.bold()"
        case .frame:
            return "\n\t.frame(width: 200, height: 100)"
        case .background:
            return "\n\t.background(Color.red)"
        case .font:
            return "\n\t.font(.title)"
        case .foregroundColor:
            return "\n\t.foregroundColor(.blue)"
        case .opacity:
            return "\n\t.opacity(0.2)"
        case .italic:
            return "\n\t.italic()"
        case .underline:
            return "\n\t.underline()"
        case .rotationEffect:
            return "\n\t.rotationEffect(Angle(degrees: 45))"
        case .shadow:
            return "\n\t.shadow(color: Color.black, radius: 3, x: 2, y: 2)"
        case .fontWeight:
            return "\n\t.fontWeight(.bold)"
        }
    }
}

struct TextView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 11)
    @State private var codeSource = CodeSource()
    @State private var codeDescription = CodeDescription()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                //코드 출력 뷰
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
            }
            .padding()
            .frame(maxHeight: .infinity) // 내부 VStack의 세로 크기를 최대화
            .navigationTitle("Text")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            TitleTextView(title: "View Preview")
            
            Text("Text")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            HStack {
                Spacer()
                Text("TEST")
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
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
        case .bold : content.bold()
        case .frame : content.frame(width: 200, height: 100)
        case .background : content.background(Color.red)
        case .font: content.font(.title)
        case .foregroundColor: content.foregroundColor(.blue)
        case .opacity: content.opacity(0.2)
        case .italic: content.italic()
        case .underline: content.underline()
        case .rotationEffect: content.rotationEffect(Angle(degrees: 45))
        case .shadow: content.shadow(color: Color.black, radius: 3, x: 2, y: 2)
        case .fontWeight: content.fontWeight(.bold)
        }
    }
}
#Preview {
    TextView()
}
