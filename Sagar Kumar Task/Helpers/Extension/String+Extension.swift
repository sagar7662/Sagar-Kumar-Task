//
//  String+Extension.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 29/11/24.
//

import Foundation
import UIKit

extension String {
    
    func getMaxWidth(for font: UIFont, height: CGFloat) -> CGFloat {
        let constrainedSize = CGSize(width: .greatestFiniteMagnitude, height: height)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let boundingBox = self.boundingRect(
            with: constrainedSize,
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )
        return ceil(boundingBox.width)
    }
    
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func attributedString(withFont font: UIFont, color: UIColor, substringStyles: [(substring: String, font: UIFont, color: UIColor)]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self, attributes: [.font : font, .foregroundColor: color])
        
        for style in substringStyles {
            let substring = style.substring
            let range = (self as NSString).range(of: substring)
            
            if range.location != NSNotFound {
                attributedString.addAttribute(.font, value: style.font, range: range)
                attributedString.addAttribute(.foregroundColor, value: style.color, range: range)
            }
        }
        
        return attributedString
    }
}
