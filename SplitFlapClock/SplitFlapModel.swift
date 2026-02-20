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
    
    
    var backgroundColor : Color   = Color.init(hex: Properties.instance.backgroundColor!)
    var textColor       : Color   = Color.init(hex: Properties.instance.textColor!)
    
    var currentCharacter: String  = ""
    var targetCharacter : String  = " "
    var flipUpper       : Bool    = false
    var flipLower       : Bool    = false
    var readyToFlip     : Bool    = true
}
