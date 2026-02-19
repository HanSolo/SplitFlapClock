//
//  FloatingPoint+Fraction.swift
//  Navigator
//
//  Created by Gerrit Grunwald on 16.01.24.
//

import Foundation

extension FloatingPoint {
    var whole   : Self { modf(self).0 }
    var fraction: Self { modf(self).1 }
}
