//
//  TutorialSwiftUIApp.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 4/30/24.
//

import SwiftUI

@main
struct TutorialSwiftUIApp: App {
    @State private var lottieComplted = false
    
    var body: some Scene {
        WindowGroup {
            if lottieComplted {
                ContentView()
            } else {
                SplashView {
                    lottieComplted.toggle()
                }
            }
        }
    }
}
