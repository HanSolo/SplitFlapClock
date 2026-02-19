//
//  CGPoint+Identifiable.swift
//  Navigator
//
//  Created by Gerrit Grunwald on 28.07.24.
//

import Foundation
import CoreGraphics.CGGeometry

extension CGPoint: @retroactive Identifiable {
    public var id: String {
        "\(self.x)-\(self.y)"
    }
}
