//
//  BaseViewController.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 01/12/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    private lazy var loadingIndicator: LoadingIndicator = {
        return LoadingIndicator()
    }()
    
    func showLoading() {
        loadingIndicator.show(on: self.view)
    }
    
    func hideLoading() {
        loadingIndicator.hide()
    }
}

