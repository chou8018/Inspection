//
//  ModelCodeNoItemCell.swift
//  Inspection
//
//  Created by Thanawat prathumset on 9/3/2564 BE.
//

import UIKit

class ModelCodeNoItemCell: UITableViewCell {
    
    @IBOutlet weak var contentPlaceholderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentPlaceholderLabel.text = "\(String.localized("mode_code_fill_information_label")) motto code/ model code/ chassis number \(String.localized("mode_code_conduct_search_label"))"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
