//
//  Constants.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 19.02.26.
//

import Foundation
import SwiftUI


public struct Constants {
    
    public static let APP_GROUP_ID           : String = "group.eu.hansolo.SplitFlapClock"
    
    public static let DARKER_BRIGHTER_FACTOR : Double = 0.85
    
    public static let DEFAULT_FLIP_TIME      : Double = 0.200
    
    public enum CharacterSet {
        case time0To5
        case time0To9
        case numeric
        case alpha
        case alphaFull
        case alphaLower
        case alphanumeric
        case alphanumericLower
        case alphanumericFull
        case alphanumericExtended
        
        var characters: [String] {
            switch self {
                case .time0To5             : return ["1", "2", "3", "4", "5", "0"]
                case .time0To9             : return ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
                case .numeric              : return [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
                case .alpha                : return [" ", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
                case .alphaFull            : return [" ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
                case .alphaLower           : return [" ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
                case .alphanumeric         : return [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
                case .alphanumericLower    : return [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
                case .alphanumericFull     : return [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
                case .alphanumericExtended : return [" ", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "-", "/", ":", ",", "", ";", "@", "#", "+", "?", "!", "%", "$", "=", "<", ">"]
            }
        }
    }
    
    public enum SplitFlapFont {
        case bebas
        case bebasRounded
        case dinCondensed
        case din
        case swagUrbano
        
        func font(size: Double) -> Font {
            switch self {
            case .bebas         : return Font.custom("Bebas Neue", size: size * 0.85)
            case .bebasRounded  : return Font.custom("Bebas Neue Semirounded", size: size * 0.85)
            case .dinCondensed  : return Font.custom("D-DIN Condensed Bold", size: size * 0.85)
            case .din           : return Font.custom("DIN Regular", size: size * 0.85)
            case .swagUrbano    : return Font.custom("Swag Urbano", size: size * 0.84)
            }
        }
        
        var sizeFactor : Double {
            switch self {
                case .bebas         : return 0.85
                case .bebasRounded  : return 0.85
                case .dinCondensed  : return 0.85
                case .din           : return 0.85
                case .swagUrbano    : return 0.84
            }
        }
    }
}
