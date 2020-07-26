//
//  CounterTableViewCell.swift
//  Counters
//
//  Created by Samuel García on 25-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

class CounterTableViewCell: UITableViewCell {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var decButton: UIButton!
    @IBOutlet weak var incButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func decAction(_ sender: Any) {
    }
    @IBAction func incButton(_ sender: Any) {
    }
    
}
