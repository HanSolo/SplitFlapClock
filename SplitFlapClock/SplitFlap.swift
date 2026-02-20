//
//  SplitFlap.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 19.02.26.
//

import SwiftUI
import Spatial

struct SplitFlap: View {
    @State private var model         : SplitFlapModel
    @State private var characterSet  : Constants.CharacterSet
    @State private var splitFlapFont : Constants.SplitFlapFont
    @State private var isLandscape   : Bool                    = UIDevice.current.orientation.isLandscape
    @State private var nextIndex     : Int                     = 1
    @State private var selectedIndex : Int                     = 0
    @State private var prevIndex     : Int                     = Constants.CharacterSet.alpha.characters.count - 1
    @State private var upperAngle    : Double                  = 0
    @State private var lowerAngle    : Double                  = -90

    
    private let flipDuration : Double = 0.200
    private let perspective  : Double = 0.05
    
    
    init(model: SplitFlapModel, characterSet: Constants.CharacterSet, splitFlapFont: Constants.SplitFlapFont) {
        self.model         = model
        self.characterSet  = characterSet
        self.splitFlapFont = splitFlapFont
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Canvas(opaque: false, colorMode: .linear, rendersAsynchronously: false) { ctx, size in
                    let width              : Double   = size.width
                    let height             : Double   = size.height
                    let darkerBackground   : Color    = Helper.darker(color: self.model.backgroundColor)
                    let brighterBackground : Color    = Helper.brighter(color: self.model.backgroundColor, factor: 0.5)
                    let gradient           : Gradient = Gradient(colors: [darkerBackground, brighterBackground, darkerBackground])
                    let fixtureY           : Double   = height * 0.4525 * 0.9875
                    let fixtureWidth       : Double   = width * 0.03333333333333 * 0.98
                    let fixtureHeight      : Double   = height * 0.095 * 0.96
                    let leftPath           : Path     = Path(CGRect(x: width * 0.0041666666666, y: fixtureY, width: fixtureWidth, height: fixtureHeight))
                    let rightPath          : Path     = Path(CGRect(x: width * 0.9625, y: fixtureY, width: fixtureWidth, height: fixtureHeight))
                    let axisY              : Double   = height * 0.4925 * 0.9875
                    let axisHeight         : Double   = height * 0.015 * 0.96
                    let axisPath           : Path     = Path(CGRect(x: width * 0.0375, y: axisY, width: 0.925 * width, height: axisHeight))
                                        
                    ctx.fill(leftPath, with: .linearGradient(gradient, startPoint: CGPoint(x: 0, y: fixtureY), endPoint: CGPoint(x: 0, y: fixtureY + fixtureHeight)))
                    ctx.fill(rightPath, with: .linearGradient(gradient, startPoint: CGPoint(x: 0, y: fixtureY), endPoint: CGPoint(x: 0, y: fixtureY + fixtureHeight)))
                    ctx.fill(axisPath, with: .linearGradient(gradient, startPoint: CGPoint(x: 0, y: axisY), endPoint: CGPoint(x: 0, y: axisY + axisHeight)))
                }
                
                // Upper Background
                Canvas(opaque: false, colorMode: .linear, rendersAsynchronously: false) { ctx, size in
                    let width            : Double                   = size.width
                    let height           : Double                   = size.height
                    let flapWidth        : Double                   = width
                    let flapHeight       : Double                   = height / 2 
                    let backgroundColor  : GraphicsContext.Shading  = GraphicsContext.Shading.color(Helper.darker(color: self.model.backgroundColor))
                    let textColor        : Color                    = Helper.darker(color: self.model.textColor)
                    let fontSize         : Double                   = height
                    let font             : Font                     = self.splitFlapFont.font(size: fontSize)
                    let character        : Text                     = Text(verbatim: self.characterSet.characters[self.nextIndex]).foregroundColor(textColor).font(font)
                                                            
                    ctx.drawLayer { ctx1 in
                        ctx1.scaleBy(x: 0.98, y: 0.97)
                        ctx1.translateBy(x: width * 0.01, y: 0)
                        ctx1.clip(to: Path(CGRect(x: 0, y: 0, width: flapWidth, height: flapHeight)))
                        
                        var upperFlap        : Path = Path()
                        upperFlap.move(to: CGPoint(x: flapWidth * 0.965987288135593, y: flapHeight))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.034012711864406, y: flapHeight))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.0340127118644068, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: 0, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: 0, y: flapHeight * 0.0770666666666667))
                        upperFlap.addCurve(to: CGPoint(x: flapWidth * 0.0637754237288136, y: 0), control1: CGPoint(x: 0, y: flapHeight * 0.0345333333333333), control2: CGPoint(x: flapWidth * 0.0285762711864407, y: 0))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.936072033898305, y: 0))
                        upperFlap.addCurve(to: CGPoint(x: flapWidth, y: flapHeight * 0.0772512820512821), control1: CGPoint(x: flapWidth * 0.971351694915254, y: 0), control2: CGPoint(x: flapWidth, y: flapHeight * 0.0346205128205128))
                        upperFlap.addLine(to: CGPoint(x: flapWidth, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.965987288135593, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.965987288135593, y: flapHeight))
                        upperFlap.closeSubpath()
                        
                        ctx1.fill(upperFlap, with: backgroundColor)
                        
                        ctx1.draw(character, at: CGPoint(x: width * 0.5, y: flapHeight * 1.1))
                    }
                }

                // Lower Background
                Canvas(opaque: false, colorMode: .linear, rendersAsynchronously: false) { ctx, size in
                    let width            : Double                   = size.width
                    let height           : Double                   = size.height
                    let flapWidth        : Double                   = width
                    let flapHeight       : Double                   = height / 2
                    let backgroundColor  : GraphicsContext.Shading  = GraphicsContext.Shading.color(Helper.brighter(color: self.model.backgroundColor))
                    let textColor        : Color                    = Helper.brighter(color: self.model.textColor)
                    let fontSize         : Double                   = height
                    let font             : Font                     = self.splitFlapFont.font(size: fontSize)
                    let character        : Text                     = Text(verbatim: self.characterSet.characters[self.selectedIndex]).foregroundColor(textColor).font(font)
                                        
                    ctx.drawLayer { ctx1 in
                        ctx1.scaleBy(x: 0.98, y: 0.97)
                        ctx1.translateBy(x: width * 0.01, y: height * 0.015)
                        ctx1.clip(to: Path(CGRect(x: 0, y: flapHeight, width: flapWidth, height: flapHeight)))
                        
                        ctx1.translateBy(x: 0, y: flapHeight)
                        var lowerFlap        : Path = Path()
                        lowerFlap.move(to: CGPoint(x: flapWidth * 0.965987288135593, y: 0))
                        lowerFlap.addLine(to: CGPoint(x: flapWidth * 0.0340127118644068, y: 0))
                        lowerFlap.addLine(to: CGPoint(x: flapWidth * 0.0340127118644068, y: flapHeight * 0.0822051282051282))
                        lowerFlap.addLine(to: CGPoint(x: 0, y: flapHeight * 0.0822051282051282))
                        lowerFlap.addLine(to: CGPoint(x: 0, y: flapHeight * 0.922933333333333))
                        lowerFlap.addCurve(to: CGPoint(x: flapWidth * 0.0637754237288136, y: flapHeight), control1: CGPoint(x: 0, y: flapHeight * 0.965466666666667), control2: CGPoint(x: flapWidth * 0.0285762711864407, y: flapHeight))
                        lowerFlap.addLine(to: CGPoint(x: flapWidth * 0.936072033898305, y: flapHeight))
                        lowerFlap.addCurve(to: CGPoint(x: flapWidth, y: flapHeight * 0.922748717948718), control1: CGPoint(x: flapWidth * 0.971351694915254, y: flapHeight), control2: CGPoint(x: flapWidth, y: flapHeight * 0.965379487179487))
                        lowerFlap.addLine(to: CGPoint(x: flapWidth, y: flapHeight * 0.0822051282051282))
                        lowerFlap.addLine(to: CGPoint(x: flapWidth * 0.965987288135593, y: flapHeight * 0.0822051282051282))
                        lowerFlap.addLine(to: CGPoint(x: flapWidth * 0.965987288135593, y: 0))
                        lowerFlap.closeSubpath()
                                                        
                        ctx1.fill(lowerFlap, with: backgroundColor)
                        
                        ctx1.draw(character, at: CGPoint(x: width * 0.5, y: flapHeight * 0.1) )
                    }
                }

                // Upper Flap
                Canvas(opaque: false, colorMode: .linear, rendersAsynchronously: false) { ctx, size in
                    let width            : Double                   = size.width
                    let height           : Double                   = size.height
                    let flapWidth        : Double                   = width
                    let flapHeight       : Double                   = height / 2
                    let backgroundColor  : GraphicsContext.Shading  = GraphicsContext.Shading.color(Helper.darker(color: self.model.backgroundColor))
                    let textColor        : Color                    = Helper.darker(color: self.model.textColor)
                    let fontSize         : Double                   = height
                    let font             : Font                     = self.splitFlapFont.font(size: fontSize)
                    let character        : Text                     = Text(verbatim: self.characterSet.characters[selectedIndex]).foregroundColor(textColor).font(font)
                                        
                    ctx.drawLayer { ctx1 in
                        ctx1.scaleBy(x: 0.98, y: 0.97)
                        ctx1.translateBy(x: width * 0.01, y: 0)
                        ctx1.clip(to: Path(CGRect(x: 0, y: 0, width: flapWidth, height: flapHeight)))
                        
                        var upperFlap        : Path = Path()
                        upperFlap.move(to: CGPoint(x: flapWidth * 0.965987288135593, y: flapHeight))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.034012711864406, y: flapHeight))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.0340127118644068, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: 0, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: 0, y: flapHeight * 0.0770666666666667))
                        upperFlap.addCurve(to: CGPoint(x: flapWidth * 0.0637754237288136, y: 0), control1: CGPoint(x: 0, y: flapHeight * 0.0345333333333333), control2: CGPoint(x: flapWidth * 0.0285762711864407, y: 0))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.936072033898305, y: 0))
                        upperFlap.addCurve(to: CGPoint(x: flapWidth, y: flapHeight * 0.0772512820512821), control1: CGPoint(x: flapWidth * 0.971351694915254, y: 0), control2: CGPoint(x: flapWidth, y: flapHeight * 0.0346205128205128))
                        upperFlap.addLine(to: CGPoint(x: flapWidth, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.965987288135593, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.965987288135593, y: flapHeight))
                        upperFlap.closeSubpath()
                        
                        ctx1.fill(upperFlap, with: backgroundColor)
                        
                        ctx1.draw(character, at: CGPoint(x: width * 0.5, y: flapHeight * 1.1))
                    }
                }
                .rotation3DEffect(.degrees(self.upperAngle),
                                  axis: (x: 1.0, y: 0.0, z: 0.0),
                                  anchor: UnitPoint(x: 0.5, y: 0.5),
                                  anchorZ: 0,
                                  perspective: self.perspective)
                            
                // Lower Flap
                Canvas(opaque: false, colorMode: .linear, rendersAsynchronously: false) { ctx, size in
                    let width            : Double                   = size.width
                    let height           : Double                   = size.height
                    let flapWidth        : Double                   = width
                    let flapHeight       : Double                   = height / 2
                    let backgroundColor  : GraphicsContext.Shading  = GraphicsContext.Shading.color(Helper.brighter(color: self.model.backgroundColor))
                    let textColor        : Color                    = Helper.brighter(color: self.model.textColor)
                    let fontSize         : Double                   = height
                    let font             : Font                     = self.splitFlapFont.font(size: fontSize)
                    let character        : Text                     = Text(verbatim: self.characterSet.characters[nextIndex]).foregroundColor(textColor).font(font)
                                                        
                    ctx.drawLayer { ctx1 in
                        ctx1.scaleBy(x: 0.98, y: 0.97)
                        ctx1.translateBy(x: width * 0.01, y: height * 0.015)
                        ctx1.clip(to: Path(CGRect(x: 0, y: 0, width: flapWidth, height: flapHeight)))
                        
                        var upperFlap        : Path = Path()
                        upperFlap.move(to: CGPoint(x: flapWidth * 0.965987288135593, y: flapHeight))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.034012711864406, y: flapHeight))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.0340127118644068, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: 0, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: 0, y: flapHeight * 0.0770666666666667))
                        upperFlap.addCurve(to: CGPoint(x: flapWidth * 0.0637754237288136, y: 0), control1: CGPoint(x: 0, y: flapHeight * 0.0345333333333333), control2: CGPoint(x: flapWidth * 0.0285762711864407, y: 0))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.936072033898305, y: 0))
                        upperFlap.addCurve(to: CGPoint(x: flapWidth, y: flapHeight * 0.0772512820512821), control1: CGPoint(x: flapWidth * 0.971351694915254, y: 0), control2: CGPoint(x: flapWidth, y: flapHeight * 0.0346205128205128))
                        upperFlap.addLine(to: CGPoint(x: flapWidth, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.965987288135593, y: flapHeight * 0.917794871794872))
                        upperFlap.addLine(to: CGPoint(x: flapWidth * 0.965987288135593, y: flapHeight))
                        upperFlap.closeSubpath()
                        
                        ctx1.fill(upperFlap, with: backgroundColor)
                        
                        ctx1.drawLayer { ctx1 in
                            ctx1.scaleBy(x: 1, y: -1)
                            ctx1.draw(character, at: CGPoint(x: width * 0.5, y: -flapHeight * 0.9))
                        }
                    }
                }
                .rotation3DEffect(.degrees(self.lowerAngle),
                                  axis: (x: 1.0, y: 0.0, z: 0.0),
                                  anchor: UnitPoint(x: 0.5, y: 0.5),
                                  anchorZ: 0,
                                  perspective: self.perspective)
            }
        }
        .onChange(of: self.model.flipUpper) {
            withAnimation(.linear(duration: self.flipDuration)) {
                self.upperAngle = -90
            } completion: {
                self.model.flipLower.toggle()
            }
        }
        .onChange(of: self.model.flipLower) {
            withAnimation(.linear(duration: self.flipDuration)) {
                self.lowerAngle = -180
            } completion: {
                self.upperAngle = 0
                self.lowerAngle = -90
                
                self.nextIndex += 1
                if self.nextIndex >= self.characterSet.characters.count { self.nextIndex = 0 }

                self.selectedIndex = self.nextIndex - 1
                if self.selectedIndex < 0 { self.selectedIndex = self.characterSet.characters.count - 1 }

                self.prevIndex = self.selectedIndex - 1
                if self.prevIndex < 0 { self.prevIndex = self.characterSet.characters.count - 1 }

                self.model.currentCharacter = self.characterSet.characters[self.selectedIndex]
                
                if self.model.currentCharacter != self.model.targetCharacter {
                    self.model.flipUpper.toggle()
                } else {
                    self.model.readyToFlip = true
                }
            }
        }
        .aspectRatio(CGSize(width: 1, height: 1.66666666666), contentMode: .fit)
    }
    
    public func isReadToFlip() -> Bool { return self.model.readyToFlip }
    
    
    public func setCharacter(character: String) -> Void {
        if !self.model.readyToFlip { return }
        if !self.characterSet.characters.contains(character) { return }
        if self.model.currentCharacter == character { return }
        self.model.targetCharacter = character
        self.model.readyToFlip = false
        self.model.flipUpper.toggle()
    }
}
