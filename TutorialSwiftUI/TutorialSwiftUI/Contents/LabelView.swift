//
//  LabelView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/2/24.
//

import SwiftUI

private let pickerCount = 4

private struct CodeSource {

    var original:String = "Label(\"Home\", systemImage: \"house\")"
    var text:[String] = Array(repeating: "", count: pickerCount)
    
    var toString: String {
        //print("CodeSource - \(text)")
        return original + text.joined()
    }
}
private struct CodeDescription {
    var original: String = "Label View : 텍스트와 이미지를 함께 출력해주는 뷰"
    var text:[String] = Array(repeating: "", count: pickerCount)

    var toString: String {
        //print("CodeDescription - \(text)")
        return original + text.joined()
    
    }
}

private enum Modifire: String, CaseIterable {
    case none
    case foregroundColor
    case font
    case padding
    case background
    case opacity
    case shadow
    case scaleEffect
    case rotationEffect
    case overlay
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .foregroundColor:
            return "\nforegroundColor : 레이블의 전경 색상 설정"
        case .font:
            return "\nfont : 레이블의 글꼴과 크기 설정"
        case .padding:
            return "\npadding : 레이블 주위에 여백 추가"
        case .background:
            return "\nbackground : 레이블의 배경에 색상 또는 이미지 추가"
        case .opacity:
            return "\nopacity : 레이블 불투명도 조절"
        case .shadow:
            return "\nshadow : 레이블 그림자 효과 설정"
        case .scaleEffect:
            return "\nscaleEffect : 레이블의 크기 조절"
        case .rotationEffect:
            return "\nrotationEffect : 레이블 회전"
        case .overlay:
            return "\noverlay : 레이블 위에 다른 뷰 배치"
        }
    }
    var code: String {
        switch self {
        case .none:
            return ""
        case .foregroundColor:
            return "\n\t.foregroundColor(.blue)"
        case .font:
            return "\n\t.font(.largeTitle)"
        case .padding:
            return "\n\t.padding()"
        case .background:
            return "\n\t.background(Color.yellow)"
        case .opacity:
            return "\n\t.opacity(0.5)"
        case .shadow:
            return "\n\t.shadow(color: .gray, radius: 5)"
        case .scaleEffect:
            return "\n\t.scaleEffect(1.2)"
        case .rotationEffect:
            return "\n\t.rotationEffect(Angle(.degrees: 50))"
        case .overlay:
            return "\n\t.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))"
        }
    }
}

struct LabelView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 11)
    @State private var codeSource = CodeSource()
    @State private var codeDescription = CodeDescription()
    
    var body: some View {
        ScrollView{
            VStack {
                
                // 코드 결과
                viewPreviewSection
                
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
            .navigationTitle("Label")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            TitleTextView(title: "View Preview")
            
            Text("Label")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Label("Home", systemImage: "house")
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
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
        case .foregroundColor: content.foregroundColor(.blue)
        case .font: content.font(.largeTitle)
        case .padding: content.padding()
        case .background: content.background(Color.yellow)
        case .opacity: content.opacity(0.5)
        case .shadow: content.shadow(color: .gray, radius: 5)
        case .scaleEffect: content.scaleEffect(1.2)
        case .rotationEffect: content.rotationEffect(.degrees(50))
        case .overlay: content.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
        }
    }
}

#Preview {
    LabelView()
}
