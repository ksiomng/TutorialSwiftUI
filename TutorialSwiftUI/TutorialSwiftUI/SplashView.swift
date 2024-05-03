//
//  SplashView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 4/30/24.
//

import SwiftUI
import Lottie

struct SplashView: View {
    
    var onLottieDidFinish: (() -> Void)? = nil
    
    var body: some View {
            VStack {
            LottieView(animation: .named("Swiftorial"))
                .resizable()
                .playbackMode(.playing(.toProgress(1.0, loopMode: .playOnce)))
                .animationDidFinish{ completed in
                    if completed {
                        onLottieDidFinish?()
                    }
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(.red)
            .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
