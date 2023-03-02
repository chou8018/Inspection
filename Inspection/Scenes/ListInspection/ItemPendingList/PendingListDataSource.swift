//
//  PendingListDataSource.swift
//  Inspection
//
//  Created by Thanawat prathumset on 4/2/2564 BE.
//

import Foundation
import UIKit


class PendingListDataSource : NSObject ,  UITableViewDataSource , UITableViewDelegate {
    var itemList : [BookInListResponse] =  []
    var didSelectRowAt : ((BookInListResponse) -> Void)?
    
    var tableType : ItemPendingList.TableType = .Default
   
    
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
        case .Default , .NotFound:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotFoundCell", for: indexPath) as! NotFoundCell
            return cell
        case .Found:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PendingListCell", for: indexPath) as! PendingListCell
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
