//
//  ShapeView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/2/24.
//

import SwiftUI

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
}

struct ShapeView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 20)
    
    var body: some View {
        VStack {
            Spacer()
            // 코드 결과
            Rectangle()
                .frame(width: 100, height: 100)
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
            
            Spacer()
            
            
            // 코드 텍스트
            VStack(alignment: .leading) {
                Text("Rectangle()\n\t.frame(width: 100, height: 100)")
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
                Text("Shape View : 도형을 출력해주는 뷰")
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

/// 코드 텍스트 - 출력할 코드 설정
private struct CodeBuilder: View {
    @Binding var selectedModifire: Modifire
    
    var body: some View {
        switch selectedModifire {
        case .none:
            return Text("")
        case .foregroundColor:
            return Text("\t.foregroundColor(.cyan)")
        case .opacity:
            return Text("\t.opacity(0.5)")
        case .shadow:
            return Text("\t.shadow(radius: 5)")
        case .scaleEffect:
            return Text("\t.scaleEffect(2)")
        case .rotationEffect:
            return Text("\t.rotationEffect(.degrees(30))")
        case .offset:
            return Text("\t.offset(x: 50, y: 60)")
        case .clipShape:
            return Text("\t.clipShape(RoundedRectangle(cornerRadius: 20))")
        case .cornerRadius:
            return Text("\t.cornerRadius(10)")
        case .blur:
            return Text("\t.blur(radius:2)")
        case .overlay:
            return Text("\t.overlay(Text(\"Rectangle\").foregroundColor(.white))")
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
        case .foregroundColor:
            return Text("foregroundColor : 도형 색상 설정")
        case .opacity:
            return Text("opacity : 도형의 불투명도 조절")
        case .shadow:
            return Text("shadow : 도형 그림자 효과 설정")
        case .scaleEffect:
            return Text("scaleEffect : 도형의 크기 조절")
        case .rotationEffect:
            return Text("rotationEffect : 도형의 회전 조절")
        case .offset:
            return Text("offset : 도형의 위치 조절")
        case .clipShape:
            return Text("clipShape : 도형의 모양 지정")
        case .cornerRadius:
            return Text("cornerRadius : 도형의 모서리 둥글게 만든다.")
        case .blur:
            return Text("blur : 도형 블러 효과 적용")
        case .overlay:
            return Text("overlay : 도형 내에 텍스트 또는 이미지 표시")
        }
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
