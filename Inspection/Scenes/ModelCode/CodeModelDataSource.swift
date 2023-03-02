//
//  CodeModelDataSource.swift
//  Inspection
//
//  Created by Thanawat prathumset on 9/3/2564 BE.
//

import Foundation
import UIKit

class CodeModelDataSource : NSObject,  UITableViewDelegate, UITableViewDataSource {
    var itemList : [ModelCodeTemplateModel] =  []
    var didSelectRowAt : ((ModelCodeTemplateModel) -> Void)?
    var didEditSelectRowAt : ((ModelCodeTemplateModel) -> Void)?
    
    var tableType : ModelCode.TableType = .Default
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableType {
        case .Default, .NotFound:
            return 1
        case .Found:
            return itemList.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        switch tableType {
        case .Default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModelCodeNoItemCell", for: indexPath) as! ModelCodeNoItemCell
            return cell
        case .NotFound:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModelCodeNotFoundCell", for: indexPath) as! ModelCodeNotFoundCell
            return cell
        case .Found:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModelCodeCell", for: indexPath) as! ModelCodeCell
            cell.bind(to: itemList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableType {
        case .Default, .NotFound:
            return tableView.height
        case .Found:
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableType {
        case .Default , .NotFound:
            return
        case .Found:
            didSelectRowAt?(itemList[indexPath.row])
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .normal, title: "แก้ไข") { [weak self]
            (contextualAction, view, boolValue) in

            guard let weakself = self else{ return }
            
            print("Action style Edit section: \(indexPath.section),  indexPath : \(indexPath.row)")
            
            
            weakself.didEditSelectRowAt?(weakself.itemList[indexPath.row])

        }
        contextItem.backgroundColor = .orangeColor

        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
    
}

