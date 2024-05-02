//
//  TextView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/1/24.
//

import SwiftUI

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
}

struct TextView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 11)
    
    var body: some View {
        VStack {
            Spacer()
            // 코드 결과
            Text("TEST")
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
            
            Spacer()
            
            
            // 코드 텍스트
            VStack(alignment: .leading) {
                Text("Text(\"TEST\")")
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
                Text("Text View : 텍스트를 출력해주는 뷰")
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
        case .bold:
            return Text("\t.bold()")
        case .frame:
            return Text("\t.frame(width: 200, height: 100)")
        case .background:
            return Text("\t.background(Color.red)")
        case .font:
            return Text("\t.font(.title)")
        case .foregroundColor:
            return Text("\t.foregroundColor(.blue)")
        case .opacity:
            return Text("\t.opacity(0.2)")
        case .italic:
            return Text("\t.italic()")
        case .underline:
            return Text("\t.underline()")
        case .rotationEffect:
            return Text("\t.rotationEffect(Angle(degrees: 45))")
        case .shadow:
            return Text("\t.shadow(color: Color.black, radius: 3, x: 2, y: 2)")
        case .fontWeight:
            return Text("\t.fontWeight(.bold)")
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
        case .bold:
            return Text("bold : 텍스트 굵은 글꼴 설정")
        case .frame:
            return Text("frame : 뷰 크기 설정")
        case .background:
            return Text("background : 배경 설정")
        case .font:
            return Text("font : 텍스트의 글꼴과 크기 설정")
        case .foregroundColor:
            return Text("foregroundColor : 텍스트의 글꼴 두께 설정")
        case .opacity:
            return Text("opacity : 텍스트의 불투명도 조절")
        case .italic:
            return Text("italic : 텍스트의 기울임꼴로 설정")
        case .underline:
            return Text("underline : 텍스트에 밑줄 추가")
        case .rotationEffect:
            return Text("rotationEffect : 텍스트 회전")
        case .shadow:
            return Text("shadow :  텍스트 그림자 효과 설정")
        case .fontWeight:
            return Text("fontWeight : 텍스트의 글꼴 두께 설정")
        }
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
