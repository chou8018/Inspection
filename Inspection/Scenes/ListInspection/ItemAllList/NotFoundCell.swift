//
//  NotFoundCell.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/2/2564 BE.
//

import UIKit

class NotFoundCell: UITableViewCell {
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        noDataLabel.text = String.localized("inspection_list_pending_no_data_label")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
