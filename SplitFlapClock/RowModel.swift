//
//  RowModel.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 22.02.26.
//

import Foundation
import SwiftUI


@Observable
public class RowModel {
    
    static let shared   : SplitFlapModel = {
        let instance = SplitFlapModel()
        return instance
    }()
    
    
    var characterSet    : Constants.CharacterSet   = Constants.CharacterSet.alphanumeric
    var splitFlapFont   : Constants.SplitFlapFont  = Constants.SplitFlapFont.din
    var noOfCharacters  : Int                      = 0 {
        didSet {
            self.splitFlaps.removeAll()
            for _ in 0 ..< noOfCharacters {
                self.splitFlaps.append(SplitFlap(model: SplitFlapModel(characterSet: self.characterSet, splitFlapFont: self.splitFlapFont, flipTime: self.flipTime)))
            }
        }
    }
    var splitFlaps      : [SplitFlap]              = []
    var backgroundColor : Color                    = Color.init(hex: Properties.instance.backgroundColor!)
    var textColor       : Color                    = Color.init(hex: Properties.instance.textColor!)
    var flipTime        : Double                   = Constants.DEFAULT_FLIP_TIME {
        didSet {
            splitFlaps.forEach { $0.setFlipTime(flipTime: self.flipTime) }
        }
    }
    
    
    init(characterSet: Constants.CharacterSet = Constants.CharacterSet.alphanumeric, splitFlapFont: Constants.SplitFlapFont = Constants.SplitFlapFont.din, noOfCharacters: Int = 0, backgroundColor: Color = Color.init(hex: Properties.instance.backgroundColor!), textColor: Color = Color.init(hex: Properties.instance.textColor!), flipTime : Double = Constants.DEFAULT_FLIP_TIME) {
        self.characterSet    = characterSet
        self.splitFlapFont   = splitFlapFont
        self.noOfCharacters  = noOfCharacters
        self.backgroundColor = backgroundColor
        self.textColor       = textColor
        self.flipTime        = flipTime
    }
    
    
    public func view() -> some View {
        return HStack {
            ForEach(0 ..< self.noOfCharacters, id: \.self) { index in
                self.splitFlaps[index]
            }
        }
    }
    
    
    public func setText(text: String) -> Void {
        for i in 0 ..< self.noOfCharacters {
            let char : String = text.characterAt(i) ?? self.characterSet.characters.last!
            self.splitFlaps[i].setCharacter(character: char)
        }
    }
    
    
    public func reset() -> Void {
        self.splitFlaps.forEach { splitFlap  in
            splitFlap.reset()
        }
    }
    
    public func selfCheck() -> Void {
        self.splitFlaps.forEach { splitFlap  in
            splitFlap.selfCheck()
        }
    }
    
}
