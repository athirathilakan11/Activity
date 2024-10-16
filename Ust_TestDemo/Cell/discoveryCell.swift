//
//  discoveryCellT.swift
//  Ust_TestDemo
//
//  Created by Athira Thilakan on 15/10/24.
//

import UIKit

class discoveryCell: UITableViewCell {

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblIpAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
