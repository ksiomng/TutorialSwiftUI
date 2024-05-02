//
//  LabelView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/2/24.
//

import SwiftUI

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
}

struct LabelView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 11)
    
    var body: some View {
        VStack {
            Spacer()
            // 코드 결과
            Label("Home", systemImage: "house")
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
            
            Spacer()
            
            
            // 코드 텍스트
            VStack(alignment: .leading) {
                Text("Label(\"Home\", systemImage: \"house\")")
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
                Text("Label View : 텍스트와 이미지를 함께 출력해주는 뷰")
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
            return Text("\t.foregroundColor(.blue)")
        case .font:
            return Text("\t.font(.largeTitle)")
        case .padding:
            return Text("\t.padding()")
        case .background:
            return Text("\t.background(Color.yellow)")
        case .opacity:
            return Text("\t.opacity(0.5)")
        case .shadow:
            return Text("\t.shadow(color: .gray, radius: 5)")
        case .scaleEffect:
            return Text("\t.scaleEffect(1.2)")
        case .rotationEffect:
            return Text("\t.rotationEffect(Angle(.degrees: 50))")
        case .overlay:
            return Text("\t.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))")
            
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
            return Text("foregroundColor : 레이블의 전경 색상 설정")
        case .font:
            return Text("font : 레이블의 글꼴과 크기 설정")
        case .padding:
            return Text("padding : 레이블 주위에 여백 추가")
        case .background:
            return Text("background : 레이블의 배경에 색상 또는 이미지 추가")
        case .opacity:
            return Text("opacity : 레이블 불투명도 조절")
        case .shadow:
            return Text("shadow : 레이블 그림자 효과 설정")
        case .scaleEffect:
            return Text("scaleEffect : 레이블의 크기 조절")
        case .rotationEffect:
            return Text("rotationEffect : 레이블 회전")
        case .overlay:
            return Text("overlay : 레이블 위에 다른 뷰 배치")
        }
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
