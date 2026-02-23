//
//  BoardView.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 23.02.26.
//

import SwiftUI
internal import Combine


struct BoardView: View {
    @State var rowModel0   : RowModel  = RowModel(noOfCharacters: 5, flipTime: 0.050)
    @State var rowModel1   : RowModel  = RowModel(noOfCharacters: 5, flipTime: 0.050)
    @State var toggle      : Bool      = false
    
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    Row(model: rowModel0)
                    Row(model: rowModel1)
                    Spacer()
                }
            }
            .padding()
            .onReceive(timer) { time in
                if self.toggle {
                    rowModel0.setText(text: "SWIFT")
                    rowModel1.setText(text: "ROCKS")
                } else {
                    rowModel0.setText(text: "DEMO ")
                    rowModel1.reset()
                }
                self.toggle.toggle()
            }
        }
    }
}
