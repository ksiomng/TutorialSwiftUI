//
//  DividerView.swift
//  TutorialSwiftUI
//
//  Created by 황민경 on 5/2/24.
//

import SwiftUI

private let pickerCount = 4

private struct CodeSource {

    var original:String = "Divider()"
    var text:[String] = Array(repeating: "", count: pickerCount)
    
    var toString: String {
        //print("CodeSource - \(text)")
        return original + text.joined()
    }
}
private struct CodeDescription {
    var original: String = "Divider View : 수평 또는 수직으로 선을 출력해주는 뷰"
    var text:[String] = Array(repeating: "", count: pickerCount)

    var toString: String {
        //print("CodeDescription - \(text)")
        return original + text.joined()
    
    }
}
/// 사용할 모디파이어 기재
private enum Modifire: String, CaseIterable {
    case none
    case opacity
    case padding
    case frame
    case background
    case offset
    
    var description: String {
        switch self {
        case .none:
            return ""
        case .opacity:
            return "\nopacity : Divider의 투명도 조절"
        case .padding:
            return "\npadding : Divider의 주위에 여백 추가"
        case .frame:
            return "\nframe : Divider의 크기 지정"
        case .background:
            return "\nbackground : Divider의 배경에 색상 또는 이미지 추가"
        case .offset:
            return "\noffset : Divider의 위치 조절"
        }
    }
    var code: String {
        switch self {
        case .none:
            return ""
        case .opacity:
            return "\n\t.opacity(0.6)"
        case .padding:
            return "\n\t.padding()"
        case .frame:
            return "\n\t.frame(height: 100)"
        case .background:
            return "\n\t.background(Color.red)"
        case .offset:
            return "\n\t.offset(y: 10)"
        }
    }
}

struct DividerView: View {
    
    /// 각각의 Picker에서 선택될 enum 타입의 모디파이어 배열
    @State private var selectedModifire: [Modifire] =
    Array(repeating: .none, count: 10)
    @State private var codeSource = CodeSource()
    @State private var codeDescription = CodeDescription()
    
    var body: some View {
        ScrollView {
            VStack {
                
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
            .navigationTitle("Divider")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            TitleTextView(title: "View Preview")
            
            Text("Divider")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            VStack {
                Text("Divider")
                    .font(.largeTitle)
                Divider()
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[0]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[1]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[2]))
                    .modifier(ModifireBuilder(selectedModifire: $selectedModifire[3]))
                Text("Divider")
                    .font(.largeTitle)
            }
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
        case .opacity: content.opacity(0.6)
        case .padding: content.padding()
        case .frame: content.frame(height: 100)
        case .background: content.background(Color.red)
        case .offset: content.offset(y: 10)
        }
    }
}

#Preview {
    DividerView()
}

