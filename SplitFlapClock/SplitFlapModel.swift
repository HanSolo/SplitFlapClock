//
//  SplitFlapModel.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 19.02.26.
//

import Foundation
import Observation
import SwiftUI

@Observable
public class SplitFlapModel {
    
    static let shared   : SplitFlapModel = {
        let instance = SplitFlapModel()
        return instance
    }()
    
        
    
    var characterSet    : Constants.CharacterSet  = .alphanumeric
    var splitFlapFont   : Constants.SplitFlapFont = .bebas
    var backgroundColor : Color                   = Color.init(hex: Properties.instance.backgroundColor!)
    var textColor       : Color                   = Color.init(hex: Properties.instance.textColor!)
    var flipTime        : Double                  = Constants.DEFAULT_FLIP_TIME
    
    var currentCharacter: String                  = Constants.CharacterSet.alphanumeric.characters.first!
    var targetCharacter : String                  = Constants.CharacterSet.alphanumeric.characters.first!
    var flipUpper       : Bool                    = false
    var flipLower       : Bool                    = false
    var readyToFlip     : Bool                    = true
    
    
    init(characterSet: Constants.CharacterSet = .alphanumeric, splitFlapFont: Constants.SplitFlapFont = .bebas, backgroundColor: Color = Color.init(hex: Properties.instance.backgroundColor!), textColor: Color = Color.init(hex: Properties.instance.textColor!), flipTime: Double = Constants.DEFAULT_FLIP_TIME) {
        self.characterSet    = characterSet
        self.splitFlapFont   = splitFlapFont
        self.backgroundColor = backgroundColor
        self.textColor       = textColor
        self.flipTime        = flipTime
    }
}
