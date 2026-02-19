//
//  ContentView.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 18.02.26.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme)       var colorScheme
    //@Environment(SplitFlapModel.self) var model : SplitFlapModel
    @State var splitFlap : SplitFlap = SplitFlap(model: SplitFlapModel())
    
    
    var body: some View {
        ZStack {
            VStack {
                TimelineView(.animation(minimumInterval: 1)) { timeline in
                    self.splitFlap
                }
                Button("Flip", action: {
                    splitFlap.setCharacter(character: "B")
                })
            }
        }
    }
}
