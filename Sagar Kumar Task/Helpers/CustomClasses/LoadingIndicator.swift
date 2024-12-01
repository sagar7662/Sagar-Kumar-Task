//
//  LoadingIndicator.swift
//  Sagar Kumar Task
//
//  Created by Sagar Kumar on 01/12/24.
//

import UIKit

class LoadingIndicator {
    
    private var loadingView: UIView?
    private var indicator: UIActivityIndicatorView?

    func show(on view: UIView) {
        guard loadingView == nil else { return }
        
        loadingView = UIView(frame: view.bounds)
        loadingView?.backgroundColor = .clear
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = loadingView?.center ?? CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        indicator?.startAnimating()
        
        if let indicator = indicator, let loadingView = loadingView {
            loadingView.addSubview(indicator)
            view.addSubview(loadingView)
        }
    }

    func hide() {
        indicator?.stopAnimating()
        loadingView?.removeFromSuperview()
        loadingView = nil
        indicator = nil
    }
}
