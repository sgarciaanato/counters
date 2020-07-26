//
//  CategoryTableViewCell.swift
//  Counters
//
//  Created by Samuel García on 25-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var examplesCollectionView: UICollectionView!
    
    var delegate : ExampleSelectionDelegate?
    
    var examplesCategory : ExamplesCategory?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        examplesCollectionView.register(UINib(nibName: "ExampleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExampleCollectionViewCell")
        
        examplesCollectionView.delegate = self
        examplesCollectionView.dataSource = self
        
        // Initialization code
    }
    
    func configure(_ examplesCategory : ExamplesCategory?) {
        self.titleLabel.text = examplesCategory?.title
        self.examplesCategory = examplesCategory
        self.examplesCollectionView.reloadData()
    }
    
}

extension CategoryTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return examplesCategory?.examples.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = examplesCategory?.examples[indexPath.item].text
        label.sizeToFit()
        return CGSize(width: label.frame.width + 40, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.setSelectedTitle(examplesCategory?.examples[indexPath.row].text ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCollectionViewCell", for: indexPath) as? ExampleCollectionViewCell {
            cell.configure(examplesCategory?.examples[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
}

protocol ExampleSelectionDelegate {
    func setSelectedTitle(_ title : String)
}
