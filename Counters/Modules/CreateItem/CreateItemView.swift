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
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!

    func configureView() {
        
        let examplesLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.exampleLabelTapped(_:)))
        self.examplesLabel.isUserInteractionEnabled = true
        self.examplesLabel.addGestureRecognizer(examplesLabelTap)
        
        let examplesAttributedString = NSMutableAttributedString(string: "Give it a name. Creative block? See examples.", attributes: [:])
        
        examplesAttributedString.addAttribute(.underlineStyle, value:NSUnderlineStyle.single.rawValue, range: NSRange(location:36,length:8))
        
        examplesLabel.attributedText = examplesAttributedString
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = CreateItemController(view : self)
        configureView()
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveAction(_ sender: Any) {
        controller?.createItem(self.titleTextfield.text)
    }
    
    @objc func exampleLabelTapped(_ sender: Any){
        self.navigationController?.performSegue(withIdentifier: "showExamples", sender: nil)
    }
    
    @IBAction func unwindToCreateItem(_ sender: UIStoryboardSegue) {
        self.saveBtn?.isEnabled = self.titleTextfield.text != ""
    }
    
    @IBAction func editingChange(_ sender: Any) {
        self.saveBtn?.isEnabled = self.titleTextfield.text != ""
    }
    
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
