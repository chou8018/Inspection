//
//  ModelCodeNotFoundCell.swift
//  Inspection
//
//  Created by Thanawat prathumset on 9/3/2564 BE.
//

import UIKit

class ModelCodeNotFoundCell: UITableViewCell {

    @IBOutlet weak var noDataMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        noDataMessageLabel.text = String.localized("mode_code_no_data_message_label")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
