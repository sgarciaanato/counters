//
//  ExampleCollectionViewCell.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

class ExampleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var exampleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ example : Example?) {
        self.exampleLabel.text = example?.text
        self.exampleLabel.sizeToFit()
    }
    
}
