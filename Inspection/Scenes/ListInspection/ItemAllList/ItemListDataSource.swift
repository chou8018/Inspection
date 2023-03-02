//
//  ItemListDataSource.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/2/2564 BE.
//

import Foundation
import UIKit

class ItemListDataSource : NSObject, UITableViewDataSource , UITableViewDelegate {
    var itemList : [BookInListResponse] =  []
    var didSelectRowAt : ((BookInListResponse) -> Void)?
    
    var tableType : ItemAllList.TableType = .Default
   
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultItemCell", for: indexPath) as! DefaultItemCell
            return cell
        case .NotFound:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotFoundCell", for: indexPath) as! NotFoundCell
            return cell
        case .Found:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListCell", for: indexPath) as! ItemListCell
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
        case .Default, .NotFound:
            return
        case .Found:
            didSelectRowAt?(itemList[indexPath.row])
        }
        
    }
    
}
