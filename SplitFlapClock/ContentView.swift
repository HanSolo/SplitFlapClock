//
//  ContentView.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 18.02.26.
//

import SwiftUI

struct ContentView: View {
    //@State private var rotate = false
    
    
    var body: some View {
        ZStack {
            RotateClockView()
        }
        /*
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.largeTitle)
                .foregroundStyle(.yellow)
                .rotation3DEffect(.degrees(45), axis: (x: 1, y: 0, z: 0))
        }
        .padding()
        */
    }
}
