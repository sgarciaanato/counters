//
//  CreateItemView.swift
//  Counters
//
//  Created by Samuel García on 24-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

class CreateItemView: UIViewController {

    @IBOutlet weak var examplesLabel: UILabel!
    
    let saveBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAction(_:)))
    

    func configureView() {
        let backBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(backAction(_:)))
        navigationItem.leftBarButtonItem = backBtn
        
        navigationItem.rightBarButtonItem = saveBtn
        
        let examplesLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.exampleLabelTapped(_:)))
        self.examplesLabel.isUserInteractionEnabled = true
        self.examplesLabel.addGestureRecognizer(examplesLabelTap)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureView()
    }
    
    @objc func backAction(_ sender: Any){
        navigationController?.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveAction(_ sender: Any){
        navigationController?.navigationController?.popViewController(animated: true)
    }
    
    @objc func exampleLabelTapped(_ sender: Any){
        performSegue(withIdentifier: "showExamples", sender: nil)
    }

}
