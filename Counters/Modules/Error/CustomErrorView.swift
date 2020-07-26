//
//  CustomErrorView.swift
//  Counters
//
//  Created by Samuel García on 26-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

class CustomErrorView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var error : ErrorModel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib(className: "CustomErrorView")
    }
    
    func configure(error : ErrorModel) {
        self.error = error
        DispatchQueue.main.async {
            self.titleLabel.text = error.title
            self.descriptionLabel.text = error.description
            self.actionButton.setTitle(error.buttonTitle, for: .normal)
        }
    }

    @IBAction func action(_ sender: Any) {
        error?.action()
    }
}
