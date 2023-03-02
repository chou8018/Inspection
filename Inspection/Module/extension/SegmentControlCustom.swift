//
//  SegmentControlCustom.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/2/2564 BE.
//

import Foundation
import UIKit

protocol CustomSegmentedControlDelegate:AnyObject {
    func change(to index:Int , button: UIButton)
}

class SegmentControlCustom: UIView {
    private var buttonTitles:[String]!
    private var buttons: [UIButton]!
    private var labels: [UILabel]!
    private var selectorView: UIView!
    
    var bgColor:UIColor?
    var textColor:UIColor = .black
    var selectorViewColor: UIColor = .red
    var selectorTextColor: UIColor = .red
    
    private var fontSize : CGFloat = 40.0
    
    var widthContent : CGFloat  = 0
    
    weak var delegate:CustomSegmentedControlDelegate?
    
    public private(set) var selectedIndex : Int = 0
    
    convenience init(frame:CGRect,buttonTitle:[String], fontSize : CGFloat = 40) {
        self.init(frame: frame)
        self.fontSize = fontSize
        self.buttonTitles = buttonTitle
    }
    
    convenience init(buttonTitle:[String], fontSize : CGFloat = 40) {
        self.init()
        self.fontSize = fontSize
        self.buttonTitles = buttonTitle
        updateView2()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor =  bgColor ?? UIColor.white
        updateView()
    }
    
    
    func setIndex(index:Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                if selectedIndex != buttonIndex {
                    delegate?.change(to: buttonIndex, button: btn)
                    selectedIndex = buttonIndex
                }
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}

//Configuration View
extension SegmentControlCustom {
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
        setIndex(index: selectedIndex)
    }
    
    private func updateView2() {
        createButton()
        configSelectorView()
        configStackView2()
        setIndex(index: selectedIndex)
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    private func configStackView2() {
        let width = labels.reduce(0) { (result, button) -> CGFloat in
            return result + button.bounds.width + 80
        }
        widthContent = width
        self.frame = CGRect(x: 0, y: 17, width: width, height: 60.0)
    }
    
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
   
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        
        labels = [UILabel]()
        labels.removeAll()
        
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            //button.setTitle(buttonTitle, for: .normal)

            let attributeString = NSAttributedString(string: buttonTitle,
                                                     attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: self.fontSize)])
            
            button.setAttributedTitle(attributeString, for: .normal)
            button.addTarget(self, action:#selector(SegmentControlCustom.buttonAction(sender:)), for: .touchDown)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
            
            
            
        }
//        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        
        for buttonTitle in buttonTitles {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            //button.setTitle(buttonTitle, for: .normal)

            let attributeString = NSAttributedString(string: buttonTitle,
                                                     attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: self.fontSize)])
            label.numberOfLines = 0
            label.attributedText = attributeString
            label.sizeToFit()
            labels.append(label)
            
            
            
        }
    }
    
    
}
