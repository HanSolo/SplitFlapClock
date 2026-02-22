//
//  Helper.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 19.02.26.
//

import Foundation
import SwiftUI


public struct Helper {
    
    public static func darker(color: Color) -> Color {
        return deriveColor(color: color, hueShift: 0, saturationFactor: 1.0, brightnessFactor: Constants.DARKER_BRIGHTER_FACTOR, opacityFactor: 1.0)
    }
    public static func darker(color: Color, factor: Double) -> Color {
        return deriveColor(color: color, hueShift: 0, saturationFactor: 1.0, brightnessFactor: factor, opacityFactor: 1.0)
    }
    
    public static func brighter(color: Color) -> Color {
        return deriveColor(color: color, hueShift: 0, saturationFactor: 1.0, brightnessFactor: 1.0 / Constants.DARKER_BRIGHTER_FACTOR, opacityFactor: 1.0)
    }
    public static func brighter(color: Color, factor: Double) -> Color {
        return deriveColor(color: color, hueShift: 0, saturationFactor: 1.0, brightnessFactor: 1.0 / factor, opacityFactor: 1.0)
    }
    
    public static func deriveColor(color: Color, hueShift: Double, saturationFactor: Double, brightnessFactor: Double, opacityFactor: Double) -> Color {
        let hsba       : (CGFloat, CGFloat, CGFloat, CGFloat) = color.getHsb()
        let hue        : CGFloat = hsba.0
        let saturation : CGFloat = hsba.1
        let brightness : CGFloat = hsba.2
        let alpha      : CGFloat = hsba.3
        
        var b : CGFloat = brightness
        if brightness == 0 && brightnessFactor > 1.0 { b = 0.05 }
        let h : CGFloat = (((hue + hueShift).truncatingRemainder(dividingBy: 360)) + 360).truncatingRemainder(dividingBy: 360)
        let s : CGFloat = max(min(saturation * saturationFactor, 1.0), 0.0)
        b               = max(min(brightness * brightnessFactor, 1.0), 0.0)
        let a : CGFloat = max(min(alpha * opacityFactor, 1.0), 0.0)
        
        return Color(hue: h, saturation: s, brightness: b, opacity: a)
    }
}
