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
    
    var delegate : CounterDelegate?
    
    var counter : Counter? {
        didSet {
            titleLabel.text = counter?.title
            let decButtonEnabled = self.counter?.count ?? 0 > 0
            decButton.isEnabled = decButtonEnabled
            decButton.alpha = decButtonEnabled ? 1 : 0.5
            counterLabel.text = "\(self.counter?.count ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        counterLabel.text = "----"
        // Initialization code
    }
    
    func configure(_ counter: Counter?){
        self.counter = counter
    }
    
    @IBAction func incButton(_ sender: Any) {
        guard let counter = counter else { return }
        delegate?.increment(counter)
    }
    
    @IBAction func decAction(_ sender: Any) {
        guard let counter = counter else { return }
        delegate?.decrement(counter)
    }
    
}

protocol CounterDelegate {
    func increment(_ counter: Counter)
    func decrement(_ counter: Counter)
}
