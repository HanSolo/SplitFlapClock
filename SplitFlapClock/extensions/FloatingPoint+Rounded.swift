//
//  FloatingPoint+Rounded.swift
//  Navigator
//
//  Created by Gerrit Grunwald on 28.07.24.
//

import Foundation

extension FloatingPoint {
    func rounded(to value: Self, roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
        (self / value).rounded(roundingRule) * value
    }
}
