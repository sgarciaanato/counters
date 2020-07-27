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
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var hiddenEditRadioButtonConstraint: NSLayoutConstraint!
    
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
    }
    
    func configure(_ counter: Counter?, editing : Bool = false, selected : Bool?){
        self.counter = counter
        hiddenEditRadioButtonConstraint.isActive = !editing
        selectButton.isEnabled = editing
        selectionImageView.image = selected ?? false ? UIImage(named: "selected-radio-button") : UIImage(named: "unselected-radio-button")
    }
    
    @IBAction func incButton(_ sender: Any) {
        guard let counter = counter else { return }
        delegate?.increment(counter)
    }
    
    @IBAction func decAction(_ sender: Any) {
        guard let counter = counter else { return }
        delegate?.decrement(counter)
    }
    
    @IBAction func selectAction(_ sender: Any) {
        isSelected = !isSelected
        guard let counter = counter else { return }
        if isSelected {
            selectionImageView.image = UIImage(named: "selected-radio-button")
            delegate?.select(counter)
        }else{
            selectionImageView.image = UIImage(named: "unselected-radio-button")
            delegate?.deselect(counter)
        }
    }
    
}

protocol CounterDelegate {
    func increment(_ counter: Counter)
    func decrement(_ counter: Counter)
    func select(_ counter: Counter)
    func deselect(_ counter: Counter)
}
