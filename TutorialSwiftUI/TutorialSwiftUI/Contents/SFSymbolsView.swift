//
//  SFSymbolsView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/2/24.
//

import SwiftUI

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
}

struct SFSymbolsView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 20)
    
    var body: some View {
        VStack {
            Spacer()
            // 코드 결과
            Image(systemName: "ladybug")
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
            
            Spacer()
            
            
            // 코드 텍스트
            VStack(alignment: .leading) {
                Text("Image(systemName:\"Image\")")
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
                Text("SFSymbols View : SFSymbols 이미지를 출력해주는 뷰")
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
        case .font:
            return Text("\t.font(.system(size: 50))")
        case .foregroundColor:
            return Text("\t.foregroundColor(.purple)")
        case .padding:
            return Text("\t.padding()")
        case .background:
            return Text("\t.background(Color.green)")
        case .opacity:
            return Text("\t.opacity(0.4)")
        case .rotationEffect:
            return Text("\t.rotationEffect(.degrees(-60))")
        case .scaleEffect:
            return Text("\t.scaleEffect(1.5)")
        case .shadow:
            return Text("\t.shadow(color: .black, radius: 10)")
        case .offset:
            return Text("\t.offset(x: 50, y: 50)")
        case .blur:
            return Text("\t.blur(radius: 3.0)")
        case .symbolVariant:
            return Text("\t.symbolVariant(.slash)")
        case .symbolEffect:
            return Text("\t.sysbolEffect(.variableColor.iterative.reversing")
        case .symbolRenderingMode:
            return Text("\t.symbolRenderingMode(.multicolor)")
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
        case .font:
            return Text("font : 아이콘의 글꼴과 크기 설정")
        case .foregroundColor:
            return Text("foregroundColor : 아이콘 색상 설정")
        case .padding:
            return Text("padding : 아이콘 주위에 여백 추가")
        case .background:
            return Text("background : 아이콘의 배경에 색상 또는 이미지 추가")
        case .opacity:
            return Text("opacity : 아이콘의 불투명도 조절")
        case .rotationEffect:
            return Text("rotationEffect : 아이콘 회전")
        case .scaleEffect:
            return Text("scaleEffect : 아이콘 크기 조절")
        case .shadow:
            return Text("shadow : 아이콘 그림자 효과 적용")
        case .offset:
            return Text("offset : 아이콘 위치 조절")
        case .blur:
            return Text("blur :  아이콘 블러 효과 적용")
        case .symbolVariant:
            return Text("symbolVariant : SFSymbol 변형 설정")
        case .symbolEffect:
            return Text("sysbolEffect : SFSymbol 특수 효과")
        case .symbolRenderingMode:
            return Text("symbolRenderingMode : SFSymbol 렌더링 모드 설정")
        }
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
