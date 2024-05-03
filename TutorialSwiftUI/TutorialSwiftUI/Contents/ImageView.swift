//
//  ImageView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/1/24.
//

import SwiftUI

private let pickerCount = 4

private struct CodeSource {

    var original:String = "Image(\"Snowball\")"
    var text:[String] = Array(repeating: "", count: pickerCount)
    
    var toString: String {
        //print("CodeSource - \(text)")
        return original + text.joined()
    }
}
private struct CodeDescription {
    var original: String = "Image View : 이미지를 출력해주는 뷰"
    var text:[String] = Array(repeating: "", count: pickerCount)

    var toString: String {
        //print("CodeDescription - \(text)")
        return original + text.joined()
    
    }
}

private enum Modifire: String, CaseIterable {
    case none
    case frame
    case scaledToFit
    case scaledToFill
    case aspectRatio
    case overlay
    case border
    case opacity
    case offset
    case rotationEffect
    case scaleEffect
    case shadow
    case clipShape
    case cornerRadius
    case blur
    case contrast
    case saturation
    case brightness
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .frame:
            return "\nframe : 이미지의 크기와 위치 설정"
        case .scaledToFit:
            return "\nscaledToFit : 이미지를 콘텐츠 프레임에 맞추도록 크기 조정"
        case .scaledToFill:
            return "\nscaledToFill : 이미지를 콘텐츠 프레임에 가득 차도록 크기 조정"
        case .aspectRatio:
            return "\naspectRatio : 이미지의 가로세로 비율 유지한 채 크기 조절"
        case .overlay:
            return "\noverlay : 이미지 위에 다른 뷰를 배치하여 테두리 생성"
        case .border:
            return "\nborder : 이미지 주위에 선을 그려 테두리 생성"
        case .opacity:
            return "\nopacity : 이미지의 불투명도 조절"
        case .offset:
            return "\noffset : 이미지 위치 조절"
        case .rotationEffect:
            return "\nrotationEffect : 이미지 회전"
        case .scaleEffect:
            return "\nscaleEffect : 이미지 크기 조절"
        case .shadow:
            return "\nshadow : 이미지 그림자 효과 설정"
        case .clipShape:
            return "\nclipShape : 이미지 모양 지정"
        case .cornerRadius:
            return "\ncornerRadius : 이미지 모서리 둥글게 조정"
        case .blur:
            return "\nblur : 이미지 블러 효과 설정"
        case .contrast:
            return "\ncontrast : 이미지 대비 조절"
        case .saturation:
            return "\nsaturation : 이미지 채도 조절"
        case .brightness:
            return "\nbrightness : 이미지 밝기 조절"
        }
    }
    var code: String {
        switch self {
        case .none:
            return ""
        case .frame:
            return "\n\t.frame(width: 100, height: 100)"
        case .scaledToFit:
            return "\n\t.scaledToFit()"
        case .scaledToFill:
            return "\n\t.scaledToFill()"
        case .aspectRatio:
            return "\n\t.aspectRatio(contentMode: .fit)"
        case .overlay:
            return "\n\t.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 10)"
        case .border:
            return "\n\t.border(Color.green, width: 4)"
        case .opacity:
            return "\n\t.opacity(0.2)"
        case .offset:
            return "\n\t.offset(x: 50, y: 20)"
        case .rotationEffect:
            return "\n\t.rotationEffect(.degrees(45))"
        case .scaleEffect:
            return "\n\t.scaleEffect(1.5)"
        case .shadow:
            return "\n\t.shadow(color: Color.black, radius: 3, x: 2, y: 2)"
        case .clipShape:
            return "\n\t.clipShape(Circle())"
        case .cornerRadius:
            return "\n\t.cornerRadius(20)"
        case .blur:
            return "\n\t.blur(radius: 5)"
        case .contrast:
            return "\n\t.contrast(1.5)"
        case .saturation:
            return "\n\t.saturation(0.5)"
        case .brightness:
            return "\n\t.brightness(0.2)"
        }
    }
}

struct ImageView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 20)
    @State private var codeSource = CodeSource()
    @State private var codeDescription = CodeDescription()
    
    var body: some View {
        ScrollView {
            VStack {
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
            .navigationTitle("Image")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            TitleTextView(title: "View Preview")
            
            Text("Image")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            HStack {
                Image("Snowball")
                    .resizable()
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
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
//        case .resizable : content.resizable()
        case .frame : content.frame(width: 100, height: 100)
        case .scaledToFit : content.scaledToFit()
        case .scaledToFill : content.scaledToFill()
        case .aspectRatio : content.aspectRatio(contentMode: .fit)
        case .overlay: content.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 10))
        case .border: content.border(Color.green, width: 4)
        case .opacity: content.opacity(0.2)
        case .offset: content.offset(x: 50, y: 20)
        case .rotationEffect: content.rotationEffect(.degrees(45))
        case .scaleEffect: content.scaleEffect(1.5)
        case .shadow: content.shadow(color: Color.black, radius: 3, x: 2, y: 2)
        case .clipShape: content.clipShape(Circle())
        case .cornerRadius: content.cornerRadius(20)
        case .blur: content.blur(radius: 5)
        case .contrast: content.contrast(1.5)
        case .saturation: content.saturation(0.5)
        case .brightness: content.brightness(0.2)
        }
    }
}

#Preview {
    ImageView()
}
