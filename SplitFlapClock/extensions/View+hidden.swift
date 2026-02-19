//
//  View+hidden.swift
//  Navigator
//
//  Created by Gerrit Grunwald on 24.06.24.
//

import Foundation
import SwiftUI

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
