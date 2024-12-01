//
//  UISearchBar+Extension.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 29/11/24.
//

import Foundation
import UIKit

extension UISearchBar {
    
    func customizeAppearance() {
        let textField = self.searchTextField
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.tintColor = .black
    }
}
