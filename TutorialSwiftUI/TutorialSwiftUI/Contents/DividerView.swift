//
//  DividerView.swift
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
    case padding
    case frame
    case background
    case offset
}

struct DividerView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 10)
    
    var body: some View {
        VStack {
            Spacer()
            // 코드 결과
            VStack{
                Divider()
                Text("Divider")
                    .font(.largeTitle)
                Divider()
                Text("Divider")
                    .font(.largeTitle)
                Divider()
            }
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
                Text("Divider View : 수평 또는 수직으로 선을 출력해주는 뷰")
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
        case .opacity:
            return Text("\t.opacity(0.6)")
        case .padding:
            return Text("\t.padding()")
        case .frame:
            return Text("\t.frame(height: 100)")
        case .background:
            return Text("\t.background(Color.red)")
        case .offset:
            return Text("\t.offset(x: 10)")
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
            return Text("foregroundColor : Divider의 색상 설정")
        case .opacity:
            return Text("opacity : Divider의 투명도 조절")
        case .padding:
            return Text("padding : Divider의 주위에 여백 추가")
        case .frame:
            return Text("frame : Divider의 크기 지정")
        case .background:
            return Text("background : Divider의 배경에 색상 또는 이미지 추가")
        case .offset:
            return Text("offset : Divider의 위치 조절")
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
        case .opacity: content.opacity(0.6)
        case .padding: content.padding()
        case .frame: content.frame(height: 100)
        case .background: content.background(Color.red)
        case .offset: content.offset(x: 10)
        }
    }
}

#Preview {
    DividerView()
}
