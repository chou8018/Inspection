//
//  damageCell.swift
//  Inspection
//
//  Created by Thanawat Pratumsat on 7/6/2564 BE.
//

import UIKit
import SDWebImage

class DamageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var option2Label: UILabel!
    @IBOutlet weak var option3Label: UILabel!
    @IBOutlet weak var deleteImageView: UIImageView!
    var model: PhotoCar.PhotoImage?
    var didTapImageDelete : ((PhotoCar.PhotoImage?) -> Void)?
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        deleteImageView.isUserInteractionEnabled = true
        deleteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteItem)))
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
        option1Label.text = model?.damageDesc
        option2Label.text = model?.damageSize
        option3Label.text = model?.damageType
        
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
