//
//  Row.swift
//  SplitFlapClock
//
//  Created by Gerrit Grunwald on 22.02.26.
//

import SwiftUI
import Foundation


struct Row: View {
    @State private var model : RowModel
    
    
    init(model : RowModel) {
        self.model = model
    }
    
    var body: some View {
        self.model.view()        
    }
        
    public func setText(text: String) -> Void {
        self.model.setText(text: text)
    }
    
    
    public func reset() -> Void {
        self.model.reset()
    }
    
    public func selfCheck() -> Void {
        self.model.selfCheck()
    }
}
