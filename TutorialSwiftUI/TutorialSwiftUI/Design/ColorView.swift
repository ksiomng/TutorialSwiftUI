//
//  ColorView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 5/1/24.
//

import SwiftUI

struct ColorView: View {
    @State private var modifierCnt = 1
    @State private var selectedModifires: [Modifire] = Array(repeating: .none, count: 10)
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                // 뷰 프리뷰
                viewPreviewSection
                
                // 코드 프리뷰
                Stepper("Modifier Cnt \(modifierCnt)", value: $modifierCnt, in: 0...10)
                
                VStack {
                    ForEach(0..<modifierCnt, id:\.self) { cnt in
                        HStack {
                            Text("Modifier \(cnt+1)")
                            Spacer()
                            
                            Picker("Modifier)", selection: $selectedModifires[cnt]) {
                                ForEach(Modifire.allCases, id: \.self) { modi in
                                    Text("\(modi.rawValue)")
                                        .tag(modi)
                                }
                            }

                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                codePreviewSection
            }
            .padding()
            .frame(maxHeight: .infinity) // 내부 VStack의 세로 크기를 최대화
            .navigationTitle("Color")
            .navigationBarTitleDisplayMode(.inline)
          
        }
    }
    
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            TitleTextView(title: "View Preview")
            
            Text("Color")
                .frame(maxWidth: .infinity, alignment: .leading)
                
            Divider()
            HStack{
                Spacer()
                returnModifier()
                Spacer()
            }
            
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var codePreviewSection: some View {
        VStack(spacing: 20) {
            TitleTextView(title: "Code Preview")
            
            CodePreviewView(code: returnCode(), copyAction: copyCode, showCopy: true)
            
            TitleTextView(title: "Base Code")
            
            CodePreviewView(code: basecode(), copyAction: copyCode, showCopy: false)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    

    // Base code
    func basecode() -> String {
        """
        Text("Hello, World")
        """
    }

    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
    
    func returnModifier() -> some View {
        let count: Int = modifierCnt

        switch count {
        case 0:
            return AnyView(Text("Hello, World!"))
        case 1:
            return AnyView(Text("Hello, World!")
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[0])))
        case 2:
            return AnyView(Text("Hello, World!")
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[0]))
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[1])))
        case 3:
            return AnyView( Text("Hello, World!")
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[0]))
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[1]))
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[2])))
        case 4:
            return  AnyView(Text("Hello, World!")
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[0]))
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[1]))
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[2]))
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[3])))
        case 5:
            return  AnyView( Text("Hello, World!")
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[0]))
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[1]))
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[2]))
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[3]))
                       .modifier(ModifireBuilder(selectedModifire: $selectedModifires[4])))
        default:
           return  AnyView(Text("Hello, World!"))
        
        }
    }
    
    func a(modifier: Modifire) -> String {
        switch modifier {
        case .bold:
            return ".bold()"
        case .frame:
            return ".frame()"
        case .background:
            return ".background(.red)"
        default: return ""
        }
    }
    
    func returnCode() -> String {
        let count: Int = modifierCnt

        switch count {
        case 0:
            return """
            Text(\"Hello, World!\")
            """
        case 1:
            
            var text = """
                   Text("Hello, World!")
                   """
               if selectedModifires[0] != .none {
                   print("ASDf")
                   text += "\n\t\(a(modifier: selectedModifires[0]))"
               }
               return text
            
        case 2:
            var text =  """
                        Text("Hello, World!")
                        """
            if selectedModifires[0] != .none {
                text += "\n\t\(a(modifier: selectedModifires[0]))"
            }
            if selectedModifires[1] != .none {
                text += "\n\t\(a(modifier: selectedModifires[1]))"
            }
            return text
        case 3:
            var text = """
                        Text("Hello, World!")
                        .frame(maxWidth: .infinity, alignment: .center)
                        """
            if selectedModifires[0] != .none {
                text += "\n\t\(a(modifier: selectedModifires[0]))"
            }
            if selectedModifires[1] != .none {
                text += "\n\t\(a(modifier: selectedModifires[1]))"
            }
            if selectedModifires[2] != .none {
                text += "\n\t\(a(modifier: selectedModifires[2]))"
            }
            return text
        case 4:
            var text =  """
                        Text("Hello, World!")
                        """
            if selectedModifires[0] != .none {
                text += "\n\t\(a(modifier: selectedModifires[0]))"
            }
            if selectedModifires[1] != .none {
                text += "\n\t\(a(modifier: selectedModifires[1]))"
            }
            if selectedModifires[2] != .none {
                text += "\n\t\(a(modifier: selectedModifires[2]))"
            }
            if selectedModifires[3] != .none {
                text += "\n\t\(a(modifier: selectedModifires[3]))"
            }
            return text
        case 5:
            var text =  """
                        Text("Hello, World!")
                        """
            if selectedModifires[0] != .none {
                text += "\n\t\(a(modifier: selectedModifires[0]))"
            }
            if selectedModifires[1] != .none {
                text += "\n\t\(a(modifier: selectedModifires[1]))"
            }
            if selectedModifires[2] != .none {
                text += "\n\t\(a(modifier: selectedModifires[2]))"
            }
            if selectedModifires[3] != .none {
                text += "\n\t\(a(modifier: selectedModifires[3]))"
            }
            if selectedModifires[4] != .none {
                text += "\n\t\(a(modifier: selectedModifires[4]))"
            }
            return text
        default:
            return """
                   Text(\"Hello, World!\")
                       .frame(maxWidth: .infinity, alignment: .center)
                   """
        
        }
    }

}




#Preview {
    ColorView()
}
