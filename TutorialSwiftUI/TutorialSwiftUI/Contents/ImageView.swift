//
//  ImageView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/1/24.
//

import SwiftUI

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
}

struct ImageView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 20)
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                // 코드 결과
                Image("Snowball")
                    .resizable()
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
                
                Spacer()
                
                
                // 코드 텍스트
                VStack(alignment: .leading) {
                    Text("Image(\"Image\")\n\t.resizable()")
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
                    Text("Image View : 이미지를 출력해주는 뷰")
                    DescriptionBuilder(selectedModifire: $selectedModifire[0])
                    DescriptionBuilder(selectedModifire: $selectedModifire[1])
                    DescriptionBuilder(selectedModifire: $selectedModifire[2])
                    DescriptionBuilder(selectedModifire: $selectedModifire[3])
                }
                .frame(width: 350)
                .font(.system(size: 18, design: .monospaced))
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
}

/// 코드 텍스트 - 출력할 코드 설정
private struct CodeBuilder: View {
    @Binding var selectedModifire: Modifire
    
    var body: some View {
        switch selectedModifire {
        case .none:
            return Text("")
        case .frame:
            return Text("\t.frame(width: 100, height: 100)")
        case .scaledToFit:
            return Text("\t.scaledToFit()")
        case .scaledToFill:
            return Text("\t.scaledToFill()")
        case .aspectRatio:
            return Text(".aspectRatio(contentMode: .fit)")
        case .overlay:
            return Text(".overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 10)")
        case .border:
            return Text(".border(Color.green, width: 4)")
        case .opacity:
            return Text("\t.opacity(0.2)")
        case .offset:
            return Text("\t.offset(x: 50, y: 20)")
        case .rotationEffect:
            return Text("\t.rotationEffect(.degrees(45))")
        case .scaleEffect:
            return Text("\t.scaleEffect(1.5)")
        case .shadow:
            return Text("\t.shadow(color: Color.black, radius: 3, x: 2, y: 2)")
        case .clipShape:
            return Text("\t.clipShape(Circle())")
        case .cornerRadius:
            return Text("cornerRadius(20)")
        case .blur:
            return Text("\t.blur(radius: 5)")
        case .contrast:
            return Text("\t.contrast(1.5)")
        case .saturation:
            return Text("\t.saturation(0.5)")
        case .brightness:
            return Text("\t.brightness(0.2)")
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
        case .frame:
            return Text("frame : 이미지의 크기와 위치 설정")
        case .scaledToFit:
            return Text("scaledToFit : 이미지를 콘텐츠 프레임에 맞추도록 크기 조정")
        case .scaledToFill:
            return Text("scaledToFill : 이미지를 콘텐츠 프레임에 가득 차도록 크기 조정")
        case .aspectRatio:
            return Text("aspectRatio : 이미지의 가로세로 비율 유지한 채 크기 조절")
        case .overlay:
            return Text("overlay : 이미지 위에 다른 뷰를 배치하여 테두리 생성")
        case .border:
            return Text("border : 이미지 주위에 선을 그려 테두리 생성")
        case .opacity:
            return Text("opacity : 이미지의 불투명도 조절")
        case .offset:
            return Text("offset : 이미지 위치 조절")
        case .rotationEffect:
            return Text("rotationEffect : 이미지 회전")
        case .scaleEffect:
            return Text("scaleEffect : 이미지 크기 조절")
        case .shadow:
            return Text("shadow : 이미지 그림자 효과 설정")
        case .clipShape:
            return Text("clipShape : 이미지 모양 지정")
        case .cornerRadius:
            return Text("cornerRadius : 이미지 모서리 둥글게 조정")
        case .blur:
            return Text("blur : 이미지 블러 효과 설정")
        case .contrast:
            return Text("contrast : 이미지 대비 조절")
        case .saturation:
            return Text("saturation : 이미지 채도 조절")
        case .brightness:
            return Text("brightness : 이미지 밝기 조절")
        }
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
