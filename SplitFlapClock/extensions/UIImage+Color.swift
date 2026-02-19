//
//  UIImage+Color.swift
//  Navigator
//
//  Created by Gerrit Grunwald on 22.12.23.
//

import Foundation
import UIKit


extension UIImage {
    func colored(_ color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.setFill()
            draw(at: .zero)
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .sourceAtop)
        }
    }        
}
