//
//  ContentView.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 18.02.26.
//

import SwiftUI
internal import Combine

struct ContentView: View {
    @State var hourLeft    : SplitFlap = SplitFlap(model: SplitFlapModel(characterSet: Constants.CharacterSet.time0To9, splitFlapFont: Constants.SplitFlapFont.bebas))
    @State var hourRight   : SplitFlap = SplitFlap(model: SplitFlapModel(characterSet: Constants.CharacterSet.time0To9, splitFlapFont: Constants.SplitFlapFont.bebas))
    @State var minuteLeft  : SplitFlap = SplitFlap(model: SplitFlapModel(characterSet: Constants.CharacterSet.time0To5, splitFlapFont: Constants.SplitFlapFont.bebas))
    @State var minuteRight : SplitFlap = SplitFlap(model: SplitFlapModel(characterSet: Constants.CharacterSet.time0To9, splitFlapFont: Constants.SplitFlapFont.bebas))
    @State var rowModel0   : RowModel  = RowModel(noOfCharacters: 5, flipTime: 0.050)
    @State var rowModel1   : RowModel  = RowModel(noOfCharacters: 5, flipTime: 0.050)
    @State var toggle      : Bool      = false
    
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape : Bool = geometry.size.width > geometry.size.height
            ZStack {
                VStack {
                    Spacer()
                    Row(model: rowModel0)
                    Row(model: rowModel1)
                    Spacer()
                    HStack {
                        self.hourLeft
                        self.hourRight
                        Text(":")
                            .font(Font.custom("Bebas Neue", size: geometry.size.height * (isLandscape ? 0.5 : 0.125)))
                            .foregroundStyle(.white)
                        self.minuteLeft
                        self.minuteRight
                    }
                    Spacer()
                }
            }
            .padding()
            .onReceive(timer) { time in
                updateClock(date: time)
                if self.toggle {
                    rowModel0.setText(text: "SWIFT")
                    rowModel1.setText(text: "ROCKS")
                } else {
                    rowModel0.setText(text: "DEMO ")
                    rowModel1.reset()
                }
                self.toggle.toggle()
            }
        }
    }
    
    private func updateClock(date: Date) {
        DispatchQueue.main.async {
            let calendar    : Calendar = Calendar.current
            let hour        : Int      = calendar.component(.hour, from: date)
            let minute      : Int      = calendar.component(.minute, from: date)
            let leftHour    : String   = hour < 10 ? "0"              : String(String(hour).first!)
            let rightHour   : String   = hour < 10 ? String(hour)     : String(String(hour).last!)
            let leftMinute  : String   = minute < 10 ? "0"            : String(String(minute).first!)
            let rightMinute : String   = minute < 10 ? String(minute) : String(String(minute).last!)
            
            if self.hourLeft.isReadToFlip() { self.hourLeft.setCharacter(character: leftHour) }
            if self.hourRight.isReadToFlip() { self.hourRight.setCharacter(character: rightHour) }
            
            if self.minuteLeft.isReadToFlip() { self.minuteLeft.setCharacter(character : leftMinute) }
            if self.minuteRight.isReadToFlip() { self.minuteRight.setCharacter(character: rightMinute) }
        }
    }
}
