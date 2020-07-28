//
//  WelcomeTableViewCell.swift
//  Counters
//
//  Created by Samuel García on 27-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

class WelcomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var iconBackground: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ welcome : WelcomeModel) {
        icon.image = UIImage(named: welcome.iconName)
        iconBackground.backgroundColor = welcome.backgroundColor
        titleLabel.text = welcome.title
        descriptionLabel.text = welcome.description
    }
    
}
