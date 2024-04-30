//
//  SplashView.swift
//  TutorialSwiftUI
//
//  Created by Chung Wussup on 4/30/24.
//

import SwiftUI

struct SplashView: View {
    @State var lottieShow = false
    
    var body: some View { 
        LottieView(lottieShow: $lottieShow)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            
    }
}

#Preview {
    SplashView()
}
