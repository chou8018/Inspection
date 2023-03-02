//
//  UIScrollView+extension.swift
//  Inspection
//
//  Created by Thanawat prathumset on 1/2/2564 BE.
//

import Foundation
import UIKit

extension UIScrollView {
    func registKeyboardNotification()
    {
        
        NotificationCenter.default.addObserver(self, selector: #selector( self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector( self.keyboardWillHide ), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.registTapGesture()
    }
    
    
    func resignKeyboardNotification()
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification:Notification) {
        guard let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        /*
        var extendsHeight:CGFloat = 0
        if let window = self.window
        {
            let height = self.y + self.height
            let screenHeight = window.screen.bounds.height
            extendsHeight = CGFloat(screenHeight - height)
        }
         */
        
        //self.contentInset.bottom = endFrame.height - extendsHeight
        self.contentInset.bottom = endFrame.height
        //self.scrollIndicatorInsets.bottom = self.contentInset.bottom
        self.verticalScrollIndicatorInsets.bottom  = self.contentInset.bottom
        
    }
    
    @objc func keyboardWillHide(notification:Notification) {
        print("keyboardWillHide bottom =  \(self.contentInset.bottom)")
//        printRed( self.contentInset )
        self.contentInset.bottom = 0
        //self.scrollIndicatorInsets.bottom = self.contentInset.bottom
        self.verticalScrollIndicatorInsets.bottom = self.contentInset.bottom
            
    }
    
    func registTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap);
    }
    
    @objc private func hideKeyboard(gesture: UITapGestureRecognizer){
        self.endEditing(true);
    }
    
    func scrollToView(view:UIView, animated: Bool) {
       if let superview = view.superview {
        let child = superview.convert(view.frame, to: self)
//           let visible = CGRect(origin: contentOffset, size: visibleSize)
//           let newOffsetX = child.minX < visible.minX ? child.minX : child.maxX > visible.maxX ? child.maxX - visible.width : nil
//           if let x = newOffsetX {
//               setContentOffset(CGPoint(x: x, y: 0), animated: animated)
//           }
        
        scrollRectToVisible(CGRect(x: child.minX, y: 0, width: self.width/2 , height: 1) , animated: true)
       }
    }
}
