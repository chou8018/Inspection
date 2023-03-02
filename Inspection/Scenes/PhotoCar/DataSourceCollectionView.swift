//
//  DataSourceCollectionView.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/3/2564 BE.
//

import Foundation
import UIKit
enum StyleCellPhoto {
    case DAMAGE
    case NORMAL
}

class DataSourceCollectionView : NSObject , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    var itemList : [PhotoCar.PhotoImage] = []
    var didTapImageDelete : ((PhotoCar.PhotoImage?) -> Void)?
    var didTapImageViewer : ((PhotoCar.PhotoImage?) -> Void)?
    var styleCell:StyleCellPhoto = .NORMAL
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch styleCell {
       
        case .DAMAGE:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DamageCell", for: indexPath) as! DamageCell
            cell.bind(model: itemList[indexPath.row])
            cell.didTapImageDelete = didTapImageDelete
            
            return cell
        case .NORMAL:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            cell.bind(model: itemList[indexPath.row])
            cell.didTapImageDelete = didTapImageDelete
            cell.didTapImageViewer = didTapImageViewer
            
            return cell
        }
       
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch styleCell {
       
        case .DAMAGE:
            let width = collectionView.width
            let height = CGFloat(180)
            return CGSize(width: width, height: height)
        case .NORMAL:
            let width = collectionView.width/3
            let height = width
            return CGSize(width: width, height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

}

