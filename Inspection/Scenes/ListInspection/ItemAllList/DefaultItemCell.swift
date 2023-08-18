//
//  DefaultItemCell.swift
//  Inspection
//
//  Created by Thanawat prathumset on 3/2/2564 BE.
//

import UIKit

class DefaultItemCell: UITableViewCell {
    
    @IBOutlet weak var tipsMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tipsMessageLabel.text = String.localized("inspection_list_tip_message_label")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
