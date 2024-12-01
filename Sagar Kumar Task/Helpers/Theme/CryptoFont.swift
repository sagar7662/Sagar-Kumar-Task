//
//  CryptoFont.swift
// Sagar Kumar Task
//
//  Created by Sagar on 28/11/24.
//

import UIKit

struct CryptoFont {
    
    private static let fontNames: [FontWeight: String] = [
        .regular: "OpenSans-Regular",
        .semiBold: "OpenSans-Semibold"
    ]
    
    enum FontWeight {
        case regular, semiBold
    }
    
    static func font(weight: FontWeight, size: CGFloat) -> UIFont {
        guard let fontName = fontNames[weight] else {
            return UIFont.systemFont(ofSize: size)
        }
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
