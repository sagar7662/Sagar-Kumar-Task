//
//  UIViewController+Extension.swift
//  Sagar Kumar Task
//
//  Created by Sagar on 28/11/24.
//

import UIKit

extension UIViewController {

    func setLeftNavBar(with text: String) {
        let leftLabel = UILabel()
        leftLabel.text = text
        leftLabel.font = CryptoFont.font(weight: .semiBold, size: 16)
        leftLabel.textColor = .white
        leftLabel.sizeToFit()

        let leftBarButton = UIBarButtonItem(customView: leftLabel)
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func showAlert(title: String? = .alert, message: String, actions: [(title: String, style: UIAlertAction.Style, handler: (() -> Void)?)] = [(.ok, .default, nil)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                action.handler?()
            }
            alert.addAction(alertAction)
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
