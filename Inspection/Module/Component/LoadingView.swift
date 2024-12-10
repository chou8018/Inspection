//
//  LoadingViewController.swift
//  Inspection
//
//  Created by Thanawat prathumset on 4/3/2564 BE.
//

import Foundation
import UIKit

class LoadingView  {
    static let shared = LoadingView()
    
    fileprivate var spinner = UIActivityIndicatorView(style: .large)
    fileprivate let view = UIView()
    fileprivate var showNumber = 0
  
    func show(){
        showNumber += 1
        
        DispatchQueue.main.async { [weak self] in
            guard let weakself = self else { return }
            
            weakself.view.backgroundColor = UIColor(white: 0, alpha: 0.7)
            weakself.spinner.color = .white
            weakself.spinner.translatesAutoresizingMaskIntoConstraints = false
            weakself.spinner.startAnimating()
            weakself.view.addSubview(weakself.spinner)

            weakself.spinner.centerXAnchor.constraint(equalTo: weakself.view.centerXAnchor).isActive = true
            weakself.spinner.centerYAnchor.constraint(equalTo: weakself.view.centerYAnchor).isActive = true
            
            
            if let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                .filter({$0.isKeyWindow}).first {
            
                weakself.view.frame = keyWindow.bounds
                keyWindow.addSubview(weakself.view)
            }
        }
        
    }
    
    func hide(){
        showNumber -= 1
        showNumber = (showNumber <= 0) ? 0 : showNumber
        DispatchQueue.main.async { [weak self] in
            guard let weakself = self else { return }
            if weakself.showNumber == 0 {
                weakself.view.removeFromSuperview()
            }
        }
    }

}
 
func showLoading(){
    LoadingView.shared.show()
}
func hideLoading(){
    LoadingView.shared.hide()
}
