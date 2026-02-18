//
//  RotateClockView.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 18.02.26.
//

import SwiftUI

struct RotateClockView: View {
    @State private var isRotating = false
    private var xAxis: CGFloat = 1.0 // nod face back and forth
    private var zAxis: CGFloat = 1.0 // rotate face left and right like a dial

    var body: some View {
        ZStack {
            Rectangle()  // x Axis Guide. Guides help me visualize the tilt motions.
                .foregroundColor( xAxis > 0 ? .black : .clear )
                .frame(width: 300, height: 3)
            Rectangle()  // z Axis Guide
                .foregroundColor( zAxis > 0 ? .blue : .clear )
                .frame(width: 3, height: 300)
            ClockFaceView()
        }
        // Rotate clock back and forth over x axis
        .rotation3DEffect(.degrees(isRotating ? 20 : -20), axis: (x: xAxis, y: 0, z:  0))
        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isRotating)
        // Spin clock face left and right over z axis
        .rotation3DEffect(.degrees(isRotating ? 20 : -20), axis: (x: 0, y: 0, z:  zAxis))
        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true).delay(1.0), value: isRotating)
        .onAppear { isRotating.toggle() }
    }
}
