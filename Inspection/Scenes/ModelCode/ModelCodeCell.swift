//
//  ModelCodeCell.swift
//  Inspection
//
//  Created by Thanawat prathumset on 9/3/2564 BE.
//

import UIKit

class ModelCodeCell: UITableViewCell {

    @IBOutlet weak var mottoModelCodeLabel: UILabel!
    @IBOutlet weak var modelCodeLabel: UILabel!
    @IBOutlet weak var chassisLabel: UILabel!
    @IBOutlet weak var desc: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(to item:ModelCodeTemplateModel){

        mottoModelCodeLabel.text = item.modelDisplay?.pdfValidateString ?? "-"
        modelCodeLabel.text = item.modelCode?.pdfValidateString ?? "-"
        chassisLabel.text = item.chassisPreCode?.pdfValidateString ?? "-"
        desc.text = item.description_BU?.pdfValidateString ?? "-"
        

    }
}
