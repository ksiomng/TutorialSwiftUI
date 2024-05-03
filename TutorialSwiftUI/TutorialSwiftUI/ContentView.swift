//
//  ContentView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 4/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ContentSection()
                ControlSection()
                ViewSection()
                NavigationSection()
                CollectionsSection()
                LayoutSection()
                DesignSection()
            }
            .navigationBarTitle("SwiftUI Elements")
        }
    }
}



// Content 섹션 모듈
struct ContentSection: View {
    var body: some View {
        Section(header: Text("Content")) {
            
            ForEach(ContentType.allCases, id:\.self) { contentType in
                NavigationLink(destination: destination(for: contentType)) {
                    Text(contentType.rawValue)
                }
            }
            
        }
    }
    
    func destination(for contentType: ContentType) -> some View {
        // contentType에 따라 다른 view를 반환하도록 구현
        switch contentType {
        case .text:
            EmptyView()
        case .textField:
            EmptyView()
        case .textEditor:
            EmptyView()
        case .image:
            EmptyView()
        case .sfSymbols:
            EmptyView()
        case .label:
            EmptyView()
        case .shape:
            EmptyView()
        case .divider:
            EmptyView()
        case .customKeyboard:
            EmptyView()
        }
    }
    
}

// Control 섹션 모듈
struct ControlSection: View {
    var body: some View {
        Section(header: Text("Control")) {
            
            ForEach(ControlType.allCases, id:\.self) { controlType in
                NavigationLink(destination: destination(for: controlType)) {
                    Text(controlType.rawValue)
                }
            }
            
        }
    }
    
    func destination(for controlType: ControlType) -> some View {
        switch controlType {
        case .button:
            EmptyView()
        case .menu:
            EmptyView()
        case .contextMenu:
            EmptyView()
        case .toggle:
            EmptyView()
        case .slider:
            EmptyView()
        case .stepper:
            EmptyView()
        case .picker:
            EmptyView()
        }
    }
    
}

// View 섹션 모듈
struct ViewSection: View {
    var body: some View {
        Section(header: Text("View")) {
            ForEach(ViewType.allCases, id:\.self) { viewType in
                NavigationLink(destination: destination(for: viewType)) {
                    Text(viewType.rawValue)
                }
            }
            
        }
    }
    
    func destination(for viewType: ViewType) -> some View {
        switch viewType {
            case .sheet:
                return AnyView(SheetView())
            case .popover:
                return AnyView(PopoverView())
            case .alert:
                return AnyView(AlertView())
            case .emptyView:
                return AnyView(EmptyView())
        }
    }
}

// Navigation 섹션 모듈
struct NavigationSection: View {
    var body: some View {
        Section(header: Text("Navigation")) {
            
            ForEach(NavigationType.allCases, id: \.self) { navigationType in
                NavigationLink(destination: destination(for: navigationType)) {
                    Text(navigationType.rawValue)
                }
            }
        }
    }
    func destination(for navigationType: NavigationType) -> some View {
        switch navigationType {
            case .navigationView:
                EmptyView()
            case .navigationStack:
                EmptyView()
            case .navigationSplitView:
                EmptyView()
            case .navigationBar:
                EmptyView()
            case .navigationLink:
                EmptyView()
            case .passAView:
                EmptyView()
            case .link:
                EmptyView()
        }
    }
}

// Collections 섹션 모듈
struct CollectionsSection: View {
    var body: some View {
        Section(header: Text("Collections")) {
            ForEach(CollectionsType.allCases, id:\.self) { collectionsType in
                NavigationLink(destination: destination(for: collectionsType)) {
                    Text(collectionsType.rawValue)
                }
            }
        }
    }
    
    func destination(for collectionsType: CollectionsType) -> some View {
        switch collectionsType {
        case .vStack:
            EmptyView()
        case .hStack:
            EmptyView()
        case .zStack:
            EmptyView()
        case .grid:
            EmptyView()
        case .lazyVGrid:
            EmptyView()
        case .lazyHGrid:
            EmptyView()
        case .scrollView:
            EmptyView()
        case .tabView:
            EmptyView()
        }
    }
}

// Layout 섹션 모듈
struct LayoutSection: View {
    var body: some View {
        Section(header: Text("Layout")) {
            ForEach(LayoutType.allCases, id: \.self) { layoutType in
                NavigationLink(destination: destination(for: layoutType)) {
                    Text(layoutType.rawValue)
                }
            }
        }
    }
    func destination(for layoutType: LayoutType) -> some View {
        switch layoutType {
        case .space:
            EmptyView()
        case .padding:
            EmptyView()
        case .frame:
            EmptyView()
        case .positionPoint:
            EmptyView()
        case .geometryReader:
            EmptyView()
        case .equalSizeViews:
            EmptyView()
        }
    }
}

// Design 섹션 모듈
struct DesignSection: View {
    var body: some View {
        Section(header: Text("Design")) {
            ForEach(DesignType.allCases, id:\.self) { designType in
                NavigationLink(destination: destination(for: designType)) {
                    Text(designType.rawValue)
                }
            }
         
        }
    }
    func destination(for designType: DesignType) -> some View {
        switch designType {
        case .color:
            AnyView(ColorView())
        case .gradient:
            AnyView(GradientView())
        }
    }
}


#Preview {
    ContentView()
}
