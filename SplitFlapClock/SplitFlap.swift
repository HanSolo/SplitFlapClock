//
//  SplitFlap.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 19.02.26.
//

import SwiftUI
import Spatial

struct SplitFlap: View {
    @State private var model              : SplitFlapModel
    @State private var flipping           : Bool                    = false
    @State private var isLandscape        : Bool                    = UIDevice.current.orientation.isLandscape
    @State private var characterSet       : Constants.CharacterSet  = .alpha
    @State private var splitFlapFont      : Constants.SplitFlapFont = .bebas
    @State private var upperRotationAngle : Angle                   = Angle(degrees: -0)
    @State private var lowerRotationAngle : Angle                   = Angle(degrees: -90)
    @State private var nextIndex          : Int                     = 1
    @State private var selectedIndex      : Int                     = 0
    @State private var prevIndex          : Int                     = Constants.CharacterSet.alpha.characters.count - 1
    
    private let aspectRatio  : Double = 1.6666666667
    private let flipDuration : Double = 5.0
    private let perspective  : Double = 0.05
    
    
    init(model: SplitFlapModel) {
        self.model = model
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Upper Background
                Canvas(opaque: false, colorMode: .linear, rendersAsynchronously: false) { ctx, size in
                    let width            : Double                   = size.width
                    let height           : Double                   = size.height
                    let flapWidth        : Double                   = width
                    let flapHeight       : Double                   = height / 2 //height / 1.87 * 0.9
                    let backgroundColor  : GraphicsContext.Shading  = self.model.backgroundColor
                    let textColor        : Color                    = self.model.textColor
                    let fontSize         : Double                   = height
                    let font             : Font                     = self.splitFlapFont.font(size: fontSize)
                    let character        : Text                     = Text(verbatim: self.characterSet.characters[self.nextIndex]).foregroundColor(textColor).font(font)
                                        
                    ctx.clip(to: Path(CGRect(x: 0, y: 0, width: flapWidth, height: flapHeight)))
                    
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
                    
                    ctx.fill(upperFlap, with: backgroundColor)
                    
                    ctx.draw(character, at: CGPoint(x: width * 0.5, y: flapHeight * 1.15))
                }

                // Lower Background
                Canvas(opaque: false, colorMode: .linear, rendersAsynchronously: false) { ctx, size in
                    let width            : Double                   = size.width
                    let height           : Double                   = size.height
                    let flapWidth        : Double                   = width
                    let flapHeight       : Double                   = height / 2
                    let backgroundColor  : GraphicsContext.Shading  = self.model.backgroundColor
                    let textColor        : Color                    = self.model.textColor
                    let fontSize         : Double                   = height
                    let font             : Font                     = self.splitFlapFont.font(size: fontSize)
                    let character        : Text                     = Text(verbatim: self.characterSet.characters[self.selectedIndex]).foregroundColor(textColor).font(font)
                                    
                    ctx.clip(to: Path(CGRect(x: 0, y: flapHeight, width: flapWidth, height: flapHeight)))
                    ctx.translateBy(x: 0, y: flapHeight)
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
                                                    
                    ctx.fill(lowerFlap, with: backgroundColor)
                    
                    ctx.draw(character, at: CGPoint(x: width * 0.5, y: flapHeight * 0.15) )
                }

                // Upper Flap
                Canvas(opaque: false, colorMode: .linear, rendersAsynchronously: false) { ctx, size in
                    let width            : Double                   = size.width
                    let height           : Double                   = size.height
                    let flapWidth        : Double                   = width
                    let flapHeight       : Double                   = height / 2
                    let backgroundColor  : GraphicsContext.Shading  = self.model.backgroundColor
                    let textColor        : Color                    = self.model.textColor
                    let fontSize         : Double                   = height
                    let font             : Font                     = self.splitFlapFont.font(size: fontSize)
                    let character        : Text                     = Text(verbatim: self.characterSet.characters[selectedIndex]).foregroundColor(textColor).font(font)
                    
                    ctx.clip(to: Path(CGRect(x: 0, y: 0, width: flapWidth, height: flapHeight)))
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
                    
                    ctx.fill(upperFlap, with: backgroundColor)
                    
                    ctx.draw(character, at: CGPoint(x: width * 0.5, y: flapHeight * 1.15))
                }
                .rotation3DEffect(.degrees(self.flipping ? -90 : 0),
                                  axis: (x: 1.0, y: 0.0, z: 0.0),
                                  anchor: UnitPoint(x: 0.5, y: 0.5),
                                  anchorZ: 0,
                                  perspective: self.perspective)
                .animation(.easeInOut(duration: self.flipDuration), value: self.flipping)
                            
                // Lower Flap
                Canvas(opaque: false, colorMode: .linear, rendersAsynchronously: false) { ctx, size in
                    let width            : Double                   = size.width
                    let height           : Double                   = size.height
                    let flapWidth        : Double                   = width
                    let flapHeight       : Double                   = height / 2
                    let backgroundColor  : GraphicsContext.Shading  = self.model.backgroundColor
                    let textColor        : Color                    = self.model.textColor
                    let fontSize         : Double                   = height
                    let font             : Font                     = self.splitFlapFont.font(size: fontSize)
                    let character        : Text                     = Text(verbatim: self.characterSet.characters[nextIndex]).foregroundColor(textColor).font(font)
                    
                    ctx.clip(to: Path(CGRect(x: 0, y: 0, width: flapWidth, height: flapHeight)))
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
                    
                    ctx.fill(upperFlap, with: backgroundColor)
                    
                    ctx.drawLayer { ctx1 in
                        ctx1.scaleBy(x: 1, y: -1)
                        ctx1.draw(character, at: CGPoint(x: width * 0.5, y: -flapHeight * self.splitFlapFont.sizeFactor))
                    }
                    
                }
                .rotation3DEffect(.degrees(self.flipping ? -180 : -90),
                                  axis: (x: 1.0, y: 0.0, z: 0.0),
                                  anchor: UnitPoint(x: 0.5, y: 0.5),
                                  anchorZ: 0,
                                  perspective: self.perspective)
                .animation(.easeOut(duration: self.flipDuration).delay(self.flipDuration), value: self.flipping)
            }
        }
        .onChange(of: self.model.targetCharacter) {
            if self.model.currentCharacter == self.model.targetCharacter { return }
            self.flipping.toggle()
            
            /*
            rotateTopFlap.setAngle(0);
            rotateBottomFlap.setAngle(90);
            nextIndex++;
            if (nextIndex >= selectedCharacterSet.length) { nextIndex = 0; }

            selectedIndex = nextIndex - 1;
            if (selectedIndex < 0) { selectedIndex = selectedCharacterSet.length - 1; }

            prevIndex = selectedIndex - 1;
            if (prevIndex < 0) { prevIndex = selectedCharacterSet.length - 1; }

            this.currentCharacter = selectedCharacterSet[selectedIndex];
            redraw();
            this.flipping.set(false);
            this.flipping.removeListener(flippingListener);

            if (this.currentCharacter.equals(this.targetCharacter)) {
                fireEvent(new FlipEvent(SplitFlap.this, null, FlipEvent.FLIP_FINISHED));
            } else {
                flip();
            }
            */
        }
    }
    
    public func getModel() -> SplitFlapModel { return self.model }
    
    public func setCharacter(character: String) -> Void {
        if !self.characterSet.characters.contains(character) { return }
        self.model.targetCharacter = character
    }
}
