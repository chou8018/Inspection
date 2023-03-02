//
//  PendingListCell.swift
//  Inspection
//
//  Created by Thanawat prathumset on 4/2/2564 BE.
//

import UIKit

class PendingListCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var subVersionLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var registrationLabel: UILabel!
    
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
        
        statusLabel.text = "Pending"
        yearLabel.text = vehicle?.buildYear
        versionLabel.text = vehicle?.model_BU
        subVersionLabel.text = vehicle?.variants
        brandLabel.text = vehicle?.make_BU

        let registration = vehicle?.registration?.trimWhiteSpace ?? ""
        registrationLabel.text = registration.isEmpty ? "-" : registration
        
    
    }
}
