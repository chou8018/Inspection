//
//  PhotoCell.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/3/2564 BE.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deleteImageView: UIImageView!
    var model: PhotoCar.PhotoImage?
    var didTapImageDelete : ((PhotoCar.PhotoImage?) -> Void)?
    var didTapImageViewer : ((PhotoCar.PhotoImage?) -> Void)?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        deleteImageView.isUserInteractionEnabled = true
        deleteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteItem)))
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectItem)))
        
    }
    
    @objc func selectItem(){
        imageView.fadeIn { [weak self] in
            guard let weakself = self else { return }
            weakself.didTapImageViewer?(weakself.model)
        }
    }
    @objc func deleteItem(){
        deleteImageView.fadeIn { [weak self] in
            guard let weakself = self else { return }
            weakself.didTapImageDelete?(weakself.model)
        }
    }
    
    func bind(model : PhotoCar.PhotoImage?){
        self.model = model
        nameLabel.text = model?.name
        
        imageView.image = nil
        
        if let image = model?.image {
            imageView.image = image
            //deleteImageView.isHidden = false
        }else{
            //deleteImageView.isHidden = true
            DispatchQueue.global().async {
                if let image = model?.base64String?.base64StringToImage() {
                    DispatchQueue.main.async { [weak self]  in
                        self?.imageView.image = image
                    }
                    
                }
            }
            
        }
    }
   
}
