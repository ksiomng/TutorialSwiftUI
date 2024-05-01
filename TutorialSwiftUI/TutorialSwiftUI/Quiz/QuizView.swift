//
//  QuizView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 4/30/24.
//

import SwiftUI

private enum Modifier: String, CaseIterable {
    case none
    case bold
    case frame
    case background
}

struct QuizView: View {
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifier: [Modifier] = Array(repeating: .none, count: 3)
    @State private var userSelectedModifiers: [Modifier] = Array(repeating: .none, count: 3)

    @State private var answerText = ""
    var body: some View {
        VStack {
            Button(action: refresh){
                Image(systemName: "arrow.clockwise")
            }
            .padding(1)
            
            // List Picker - 위치별 모디파이어 선택
            List {
                Picker("First", selection: $userSelectedModifiers[0]) {
                    ForEach(Modifier.allCases, id: \.self) { modi in
                        Text("\(modi.rawValue)")
                            .tag(modi)
                    }
                }
                Picker("Second", selection: $userSelectedModifiers[1]) {
                    ForEach(Modifier.allCases, id: \.self) { modi in
                        Text("\(modi.rawValue)")
                            .tag(modi)
                    }
                }
                Picker("Third", selection: $userSelectedModifiers[2]) {
                    ForEach(Modifier.allCases, id: \.self) { modi in
                        Text("\(modi.rawValue)")
                            .tag(modi)
                    }
                }
            }.frame(height: 200)
            
            // 코드 텍스트
            VStack(alignment: .leading) {
                Text("Text(\"TEST\")")
                CodeBuilder(selectedModifier: $selectedModifier[0])
                CodeBuilder(selectedModifier: $selectedModifier[1])
                CodeBuilder(selectedModifier: $selectedModifier[2])
                //CodeBuilder(selectedModifier: $selectedModifier[3])
            }
            .frame(width: 350)
            .font(.system(size: 20, design: .monospaced))
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            Spacer()
            
            // 코드 결과
            Text("TEST")
                .font(.largeTitle)
                .modifier(ModifierBuilder(selectedModifier: $selectedModifier[0]))
                .modifier(ModifierBuilder(selectedModifier: $selectedModifier[1]))
                .modifier(ModifierBuilder(selectedModifier: $selectedModifier[2]))
                //.modifier(ModifierBuilder(selectedModifier: $selectedModifier[3]))
            
            Spacer()
            
            Button(action: checkAnswers) {
                Text("정답 확인")
                    .frame(width: 150, height: 70 ,alignment:.center)
                    .background(.blue)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
            }
        }
        .onAppear(perform: generateRandomModifiers)
    }
    func generateRandomModifiers() {
            selectedModifier = (0..<3).map { _ in
                Modifier.allCases.randomElement()!
            }
        }
        
    // 새로고침
    func refresh() {
        generateRandomModifiers()
        userSelectedModifiers = Array(repeating: .none, count: 3)
    }
        
   
    func checkAnswers() {
        // userSelectedModifiers와 selectedModifier 배열의 크기가 다르면 오류 출력 후 종료
        guard userSelectedModifiers.count == selectedModifier.count else {
            print("Error: Sizes of userSelectedModifiers and selectedModifier are different.")
            return
        }
        
        for index in 0..<userSelectedModifiers.count {
            // 유효한 인덱스인지 확인 후 비교
            if index < selectedModifier.count && index < userSelectedModifiers.count {
                if userSelectedModifiers[index] == selectedModifier[index] {
                    print("Your choice for modifier \(index + 1) is correct!")
                } else {
                    print("Your choice for modifier \(index + 1) is incorrect.")
                }
            } else {
                print("Error: Index out of range.")
                return
            }
        }
    }
}

/// 코드 텍스트 - 출력할 코드 설정
private struct CodeBuilder: View {
    @Binding var selectedModifier: Modifier
    
    var body: some View {
        switch selectedModifier {
        case .none:
            return Text("")
        case .bold:
            return Text("\t.bold()")
        case .frame:
            return Text("\t.frame(width: 200, height: 100)")
        case .background:
            return Text("\t.background(Color.red)")
        }
    }
}

/// 코드 결과 - 부여할 모디파이어 설정
private struct ModifierBuilder: ViewModifier {
    @Binding var selectedModifier: Modifier
    
    func body(content: Content) -> some View {
        switch selectedModifier {
        case .none : content
        case .bold : content.bold()
        case .frame : content.frame(width: 200, height: 100)
        case .background : content.background(Color.red)
        }
    }
}



#Preview {
    QuizView()
}
