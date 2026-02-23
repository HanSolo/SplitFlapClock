//
//  ContentView.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 18.02.26.
//

import SwiftUI
internal import Combine

struct ContentView: View {    
    var body: some View {
        TabView {
            Tab {
                ClockView()
            }
            Tab {
                BoardView()
            }
        }
    }
}
