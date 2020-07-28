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
    @IBOutlet weak var titleTextfield: UITextField!
    
    var controller : CreateItemController?
    
    var saveBtn : UIBarButtonItem?
    

    func configureView() {
        let backBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(backAction(_:)))
        navigationItem.leftBarButtonItem = backBtn
        
        saveBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAction(_:)))
        
        navigationItem.rightBarButtonItem = saveBtn
        
        let examplesLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.exampleLabelTapped(_:)))
        self.examplesLabel.isUserInteractionEnabled = true
        self.examplesLabel.addGestureRecognizer(examplesLabelTap)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = CreateItemController(view : self)
        configureView()
    }
    
    @objc func backAction(_ sender: Any){
        navigationController?.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveAction(_ sender: Any){
        controller?.createItem(self.titleTextfield.text)
    }
    
    @objc func exampleLabelTapped(_ sender: Any){
        self.navigationController?.performSegue(withIdentifier: "showExamples", sender: nil)
    }
    
    @IBAction func unwindToCreateItem(_ sender: UIStoryboardSegue) { }
    
    func setSelectedTitle(_ text : String) {
        self.titleTextfield.text = text
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainView = segue.destination as? MainView {
            guard let counters = controller?.getCounterList() else { return }
            mainView.updateList(counters)
        }
    }

}
