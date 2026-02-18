//
//  ClockFaceView.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 18.02.26.
//

import SwiftUI

struct ClockFaceView: View {
    var body: some View {
        // Clock Face
        Circle()
            .foregroundColor(.cyan).opacity(0.8)
            .frame(width: 200, height: 200, alignment: .center)
        // Ticks
        ForEach(0..<60) {
            Circle()
                .foregroundColor($0.isMultiple(of: 5) ? .blue : .white)
                .frame(width: $0.isMultiple(of: 5) ? 8 : 3, height: 8)
                .offset(y: -90)
                .rotationEffect(.degrees(Double($0) * 6)) // rotate the tick marks
        }
    }
}
