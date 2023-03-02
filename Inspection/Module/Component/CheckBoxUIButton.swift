//
//  CheckBoxUIButton.swift
//  Inspection
//
//  Created by Thanawat prathumset on 9/2/2564 BE.
//

import Foundation
import UIKit


class CheckBoxUIButton : UIButton {
    var fillImage = UIImage(named: "icon-check-fill")
    var fillImage2 = UIImage(named: "icon-check-fill-disable")
    var outlineImage = UIImage(named: "icon-check-outline")
    
    
    
    
    var callBack : ((Bool) -> Void)?
    enum TYPECHECK  {
        case IMAGE
        case BACKGROUND
    }
    var typecheck : TYPECHECK =  .IMAGE
    var check : Bool = false {
        didSet{
            updateUI()
        }
    }
    
    func toggle(callback : ((Bool) -> Void)? = nil){
        check.toggle()
        callback?(check)
    }
    func updateUI(){
        switch typecheck {
       
        case .IMAGE:
            let fille = isEnabled ? fillImage : fillImage2
            self.setBackgroundImage(check ? fille : outlineImage , for: .normal)
        case .BACKGROUND:
            self.backgroundColor = check ? (isEnabled ? .orangeColor : .gullgray) : .white
            self.setTitleColor(check ? .white : .appPrimaryColor, for: .normal)
        }
        
    }
    
    func setEnableView(isEnable : Bool){
        self.isEnabled = isEnable
    }
}
 
