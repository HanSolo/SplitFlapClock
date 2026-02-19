//
//  Storage.swift
//  GlucoTracker
//
//  Created by Gerrit Grunwald on 01.08.20.
//  Copyright © 2020 Gerrit Grunwald. All rights reserved.
//

import Foundation
import SwiftUI
import os.log


extension Key {
    static let backgroundColor : Key = "backgroundColor"
    static let textColor       : Key = "textColor"
}


// Define storage
public struct Properties {
    
    static var instance = Properties()
    
    @UserDefault(key: .backgroundColor, defaultValue: "#323238")
    var backgroundColor: String? // background color
    
    @UserDefault(key: .textColor, defaultValue: "#f2f2f2")
    var textColor: String? // text color
    
    
    private init() {}
}
