//
//  ItemListCell.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/2/2564 BE.
//

import UIKit

class ItemListCell: UITableViewCell {

    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var registrationLabel: UILabel!
    
    @IBOutlet weak var vinLabel: UILabel!
    @IBOutlet weak var chassisNumberLabel: UILabel!
  //  @IBOutlet weak var bodyNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(to item : BookInListResponse) {
        let vehicle = item.vehicle
        var detail = "\(vehicle?.buildYear ?? "")"
        detail += " \(vehicle?.make_BU ?? "")"
        detail += " \(vehicle?.model_BU ?? "")"
        detail += " \(vehicle?.variants ?? "")"
        detailLabel.text = detail.trimWhiteSpace.isEmpty ? "-" : detail
        
        let registration = vehicle?.registration?.trimWhiteSpace ?? ""
        registrationLabel.text = registration.isEmpty ? "-" : registration
        
        let vin = vehicle?.vin?.trimWhiteSpace ?? ""
        vinLabel.text = vin.isEmpty ? "-" : vin
        
//        let engineNumber = vehicle?.engineNumber?.trimWhiteSpace ?? ""
//        chassisNumberLabel.text = engineNumber.isEmpty ? "-" : engineNumber

        let bookInNumber = item.bookInNumber ?? "-"
        chassisNumberLabel.text = bookInNumber
    }
}
