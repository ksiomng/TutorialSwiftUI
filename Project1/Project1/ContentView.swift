//
//  ContentView.swift
//  Project1
//
//  Created by Song Kim on 4/30/24.
//

import SwiftUI

struct Modi {
    let bold: String = "bold"
    let background: String = "background"
}



struct ContentView: View {
    var body: some View {
        VStack {
            NavigationView {
                List {
                    NavigationLink {
                        TextView()
                    } label: {
                        Text("text")
                    }
                }
                .navigationTitle("Test")
            }
        }
    }
}

#Preview {
    ContentView()
}
