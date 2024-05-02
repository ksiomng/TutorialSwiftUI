//
//  GradientView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 5/2/24.
//

import SwiftUI


enum CustomUnitPoint: CaseIterable{
    case topLeading
    case top
    case topTrailing
    case leading
    case center
    case trailing
    case bottomLeading
    case bottom
    case bottomTrailing
    
    func toUnitPoint() -> UnitPoint {
        switch self {
        case .topLeading:
            return .topLeading
        case .top:
            return .top
        case .topTrailing:
            return .topTrailing
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        case .bottomLeading:
            return .bottomLeading
        case .bottom:
            return .bottom
        case .bottomTrailing:
            return .bottomTrailing
        }
    }
    
    func toString() -> String {
        switch self {
        case .topLeading:
            return "topLeading"
        case .top:
            return "top"
        case .topTrailing:
            return "topTrailing"
        case .leading:
            return "leading"
        case .center:
            return "center"
        case .trailing:
            return "trailing"
        case .bottomLeading:
            return "bottomLeading"
        case .bottom:
            return "bottom"
        case .bottomTrailing:
            return "bottomTrailing"
        }
    }
}

struct GradientView: View {
    
    @State private var selectedGradient = "Linear Gradient"
    @State private var startPoint: CustomUnitPoint = .topLeading
    @State private var endPoint: CustomUnitPoint = .topLeading
    
    @State private var startRadius: CGFloat = 0
    @State private var endRadius: CGFloat = 0
    @State private var radialCenter: CustomUnitPoint = .center
    
    @State private var angularCenter: CustomUnitPoint = .center
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 뷰 프리뷰
                
                viewPreviewSection
                
                codePreviewSection
                
            }
            .padding()
            .navigationTitle("Gradient View")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var viewPreviewSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            TitleTextView(title: "View Preview")
            
            Text("Gradient View")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            Divider()
            
            HStack {
                Spacer()
                Text("Check Gradient")
                    .padding()
                Spacer()
            }
            .padding()
            .background(
                Group {
                    if selectedGradient == "Linear Gradient" {
                        LinearGradient(gradient: Gradient(colors: [.blue, .white, .pink]), startPoint: startPoint.toUnitPoint(), endPoint: endPoint.toUnitPoint())
                    } else if selectedGradient == "Radial Gradient" {
                        // 원형 그라데이션 설정
                        RadialGradient(gradient: Gradient(colors: [.blue, .white, .pink]), center: radialCenter.toUnitPoint(), startRadius: startRadius, endRadius: endRadius)
                    } else if selectedGradient == "Angular Gradient" {
                        // 각도 그라데이션 설정
                        AngularGradient(gradient: Gradient(colors: [.blue, .white, .pink]), center: angularCenter.toUnitPoint())
                    } else {
                        // 기본값
                        LinearGradient(gradient: Gradient(colors: [.blue, .white, .pink]), startPoint: startPoint.toUnitPoint(), endPoint: endPoint.toUnitPoint())
                    }
                }
            )
            .cornerRadius(10)
            
            
            Picker("Gradient", selection: $selectedGradient) {
                ForEach(["Linear Gradient", "Radial Gradient", "Angular Gradient"], id: \.self) { gradientType in
                    Text(gradientType)
                }
            }
            .pickerStyle(.inline)
            .frame(maxHeight: 100)
            
            if selectedGradient == "Linear Gradient" {
                linearSelectView()
                    .frame(maxWidth: .infinity)
            } else if selectedGradient == "Radial Gradient" {
                radialStepperView()
                    .frame(maxWidth: .infinity)
            } else if selectedGradient == "Angular Gradient" {
                angularGradient()
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    func linearSelectView() -> some View {
        HStack(alignment: .center, spacing: 10) {
            VStack {
                Text("StartPoint")
                Picker("StartPoint", selection: $startPoint) {
                    ForEach(CustomUnitPoint.allCases, id: \.self) { type in
                        Text(type.toString())
                    }
                }
                .onChange(of: startPoint) { oldValue, newValue in
                    startPoint = newValue
                }
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                Text("EndPoint")
                Picker("EndPoind", selection: $endPoint) {
                    ForEach(CustomUnitPoint.allCases, id: \.self) { type in
                        Text(type.toString())
                    }
                }
                .onChange(of: endPoint) { oldValue, newValue in
                    endPoint = newValue
                }
            }
            .frame(maxWidth: .infinity)
        }
        
    }
    
    func radialStepperView() -> some View {
        VStack {
            Stepper("StartRadius: \(Int(startRadius))", value: $startRadius, in: 0...100)
                .onChange(of: startRadius) { oldValue, newValue in
                    startRadius = newValue
                }
            Stepper("endRadius: \(Int(endRadius))", value: $endRadius, in: 0...100)
                .onChange(of: endRadius) { oldValue, newValue in
                    endRadius = newValue
                }
            
            HStack {
                Text("Center")
                Spacer()
                Picker("RadialCenter", selection: $radialCenter) {
                    ForEach(CustomUnitPoint.allCases, id: \.self) { type in
                        Text(type.toString())
                    }
                }
                .onChange(of: radialCenter) { oldValue, newValue in
                    radialCenter = newValue
                }
            }
            
            
        }
    }
    
    func angularGradient() -> some View {
        HStack {
            Text("Center")
            Spacer()
            Picker("AngularCenter", selection: $angularCenter) {
                ForEach(CustomUnitPoint.allCases, id: \.self) { type in
                    Text(type.toString())
                }
            }
            .onChange(of: angularCenter) { oldValue, newValue in
                angularCenter = newValue
            }
        }
    }
    // Code Preview Section
    private var codePreviewSection: some View {
        VStack(spacing: 20) {
            TitleTextView(title: "Code Preview")
            
            CodePreviewView(code: sheetViewCode(), copyAction: copyCode,showCopy: true)
            
            TitleTextView(title: "Base Code")
            
            CodePreviewView(code: basecode(), copyAction: copyCode, showCopy: false)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
    func copyCode(_ code: String) {
        UIPasteboard.general.string = code
    }
    
    // Code Preview
    func sheetViewCode() -> String {
        if selectedGradient == "Linear Gradient" {
            let text = 
        """
        .backgroungd(
            LinearGradient(gradient: Gradient(colors: [.blue, .white, .pink]),
                                              startPoint: .\(startPoint.toString()),
                                              endPoint: .\(endPoint.toString())
                                    )
                    )
        """
            return text
        } else if selectedGradient == "Radial Gradient" {
            let text =
            """
            .background(
                        RadialGradient(gradient: Gradient(colors: [.blue, .white, .pink]),
                                                          center: .\(radialCenter.toString()),
                                                          startRadius: \(startRadius),
                                                          endRadius: \(endRadius)
                        )
            """
            
            
            return text
        } else if selectedGradient == "Angular Gradient" {
            let text =
            """
            .background(
                        AngularGradient(gradient: Gradient(colors: [.blue, .white, .pink]),
                                                           center: .\(angularCenter.toString())
                        )
            
            )
            """
            
            return text
        } else { return ""}
    }
    
    // Base code
    func basecode() -> String {
        if selectedGradient == "Linear Gradient" {
            let text =
        """
        .backgroungd(
            LinearGradient(gradient: Gradient(colors: [.blue, .white, .pink]),
                                              startPoint: .topLeading,
                                              endPoint: .topLeading)
                                    )
                    )
        """
            return text
        } else if selectedGradient == "Radial Gradient" {
            let text =
            """
            .background(
                        RadialGradient(gradient: Gradient(colors: [.blue, .white, .pink]),
                                                          center: .center),
                                                          startRadius: 0,
                                                          endRadius: 0
                        )
            """
            
            
            return text
        } else if selectedGradient == "Angular Gradient" {
            let text =
            """
            .background(
                        AngularGradient(gradient: Gradient(colors: [.blue, .white, .pink]),
                                                           center: .center
                        )
            
            )
            """
            
            return text
        } else { return ""}
    }
}

#Preview {
    GradientView()
}
