//
//  ShapeView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/2/24.
//

import SwiftUI

private let pickerCount = 4

private struct CodeSource {

    var original:String = "Rectangle()\n\t.frame(width: 100, height: 100)"
    var text:[String] = Array(repeating: "", count: pickerCount)
    
    var toString: String {
        //print("CodeSource - \(text)")
        return original + text.joined()
    }
}
private struct CodeDescription {
    var original: String = "Shape View : 도형을 출력해주는 뷰"
    var text:[String] = Array(repeating: "", count: pickerCount)

    var toString: String {
        //print("CodeDescription - \(text)")
        return original + text.joined()
    
    }
}

/// 사용할 모디파이어 기재
private enum Modifire: String, CaseIterable {
    case none
    case foregroundColor
    case opacity
    case shadow
    case scaleEffect
    case rotationEffect
    case offset
    case clipShape
    case cornerRadius
    case blur
    case overlay
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .foregroundColor:
            return "\nforegroundColor : 도형 색상 설정"
        case .opacity:
            return "\nopacity : 도형의 불투명도 조절"
        case .shadow:
            return "\nshadow : 도형 그림자 효과 설정"
        case .scaleEffect:
            return "\nscaleEffect : 도형의 크기 조절"
        case .rotationEffect:
            return "\nrotationEffect : 도형의 회전 조절"
        case .offset:
            return "\noffset : 도형의 위치 조절"
        case .clipShape:
            return "\nclipShape : 도형의 모양 지정"
        case .cornerRadius:
            return "\ncornerRadius : 도형의 모서리 둥글게 만든다."
        case .blur:
            return "\nblur : 도형 블러 효과 적용"
        case .overlay:
            return "\noverlay : 도형 내에 텍스트 또는 이미지 표시"
        }
    }
    var code: String {
        switch self {
        case .none:
            return ""
        case .foregroundColor:
            return "\n\t.foregroundColor(.cyan)"
        case .opacity:
            return "\n\t.opacity(0.5)"
        case .shadow:
            return "\n\t.shadow(radius: 5)"
        case .scaleEffect:
            return "\n\t.scaleEffect(2)"
        case .rotationEffect:
            return "\n\t.rotationEffect(.degrees(30))"
        case .offset:
            return "\n\t.offset(x: 50, y: 60)"
        case .clipShape:
            return "\n\t.clipShape(RoundedRectangle(cornerRadius: 20))"
        case .cornerRadius:
            return "\n\t.cornerRadius(10)"
        case .blur:
            return "\n\t.blur(radius:2)"
        case .overlay:
            return "\n\t.overlay(Text(\"Rectangle\").foregroundColor(.white))"
        }
    }
}

struct ShapeView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 20)
    @State private var codeSource = CodeSource()
    @State private var codeDescription = CodeDescription()
    
    var body: some View {
        ScrollView{
            VStack (spacing: 20){
                
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
            .navigationTitle("Shape")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            TitleTextView(title: "View Preview")
            
            Text("Shape")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            HStack {
                Spacer()
                Rectangle()
                    .frame(width: 100, height: 100)
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
        case .foregroundColor: content.foregroundColor(.cyan)
        case .opacity: content.opacity(0.5)
        case .shadow: content.shadow(radius: 5)
        case .scaleEffect: content.scaleEffect(2)
        case .rotationEffect: content.rotationEffect(.degrees(30))
        case .offset: content.offset(x: 50, y: 60)
        case .clipShape: content.clipShape(RoundedRectangle(cornerRadius: 20))
        case .cornerRadius: content.cornerRadius(10)
        case .blur: content.blur(radius:2)
        case .overlay: content.overlay(Text("Rectangle").foregroundColor(.white))
        }
    }
}

#Preview {
    ShapeView()
}
