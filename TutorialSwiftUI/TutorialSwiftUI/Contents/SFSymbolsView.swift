//
//  SFSymbolsView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/2/24.
//

import SwiftUI

private let pickerCount = 4

private struct CodeSource {

    var original:String = "Image(systemName: \"ladybug\")"
    var text:[String] = Array(repeating: "", count: pickerCount)
    
    var toString: String {
        //print("CodeSource - \(text)")
        return original + text.joined()
    }
}
private struct CodeDescription {
    var original: String = "SFSymbols View : SFSymbols 이미지를 출력해주는 뷰"
    var text:[String] = Array(repeating: "", count: pickerCount)

    var toString: String {
        //print("CodeDescription - \(text)")
        return original + text.joined()
    
    }
}

private enum Modifire: String, CaseIterable {
    case none
    case font
    case foregroundColor
    case padding
    case background
    case opacity
    case rotationEffect
    case scaleEffect
    case shadow
    case offset
    case blur
    case symbolVariant
    case symbolRenderingMode
    case symbolEffect
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .font:
            return "\nfont : 아이콘의 글꼴과 크기 설정"
        case .foregroundColor:
            return "\nforegroundColor : 아이콘 색상 설정"
        case .padding:
            return "\npadding : 아이콘 주위에 여백 추가"
        case .background:
            return "\nbackground : 아이콘의 배경에 색상 또는 이미지 추가"
        case .opacity:
            return "\nopacity : 아이콘의 불투명도 조절"
        case .rotationEffect:
            return "\nrotationEffect : 아이콘 회전"
        case .scaleEffect:
            return "\nscaleEffect : 아이콘 크기 조절"
        case .shadow:
            return "\nshadow : 아이콘 그림자 효과 설정"
        case .offset:
            return "\noffset : 아이콘 위치 조절"
        case .blur:
            return "\nblur :  아이콘 블러 효과 적용"
        case .symbolVariant:
            return "\nsymbolVariant : SFSymbol 변형 설정"
        case .symbolEffect:
            return "\nsysbolEffect : SFSymbol 특수 효과"
        case .symbolRenderingMode:
            return "\nsymbolRenderingMode : SFSymbol 렌더링 모드 설정"
        }
    }
    var code: String {
        switch self {
        case .none:
            return ""
        case .font:
            return "\n\t.font(.system(size: 50))"
        case .foregroundColor:
            return "\n\t.foregroundColor(.purple)"
        case .padding:
            return "\n\t.padding()"
        case .background:
            return "\n\t.background(Color.green)"
        case .opacity:
            return "\n\t.opacity(0.4)"
        case .rotationEffect:
            return "\n\t.rotationEffect(.degrees(-60))"
        case .scaleEffect:
            return "\n\t.scaleEffect(1.5)"
        case .shadow:
            return "\n\t.shadow(color: .black, radius: 10)"
        case .offset:
            return "\n\t.offset(x: 50, y: 50)"
        case .blur:
            return "\n\t.blur(radius: 3.0)"
        case .symbolVariant:
            return "\n\t.symbolVariant(.fill)"
        case .symbolEffect:
            return "\n\t.sysbolEffect(.variableColor.iterative.reversing"
        case .symbolRenderingMode:
            return "\n\t.symbolRenderingMode(.multicolor)"
        }
    }
}

struct SFSymbolsView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 20)
    @State private var codeSource = CodeSource()
    @State private var codeDescription = CodeDescription()
    
    var body: some View {
        ScrollView {
            VStack {
                
                viewPreviewSection
                // 코드 결과
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
            .navigationTitle("SFSymbols")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10){
            TitleTextView(title: "View Preview")
            
            Text("SFSymbols")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Image(systemName: "ladybug")
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
        case .font: content.font(.system(size: 50))
        case .foregroundColor: content.foregroundColor(.purple)
        case .padding: content.padding()
        case .background: content.background(Color.green)
        case .opacity: content.opacity(0.4)
        case .rotationEffect: content.rotationEffect(.degrees(-60))
        case .scaleEffect: content.scaleEffect(1.5)
        case .shadow: content.shadow(color: .black, radius: 10)
        case .offset: content.offset(x: 50, y: 50)
        case .blur: content.blur(radius: 3.0)
        case .symbolVariant: content.symbolVariant(.fill)
        case .symbolEffect: content.symbolEffect(.variableColor.iterative.reversing)
        case .symbolRenderingMode: content.symbolRenderingMode(.multicolor)
        }
    }
}

#Preview {
    SFSymbolsView()
}
