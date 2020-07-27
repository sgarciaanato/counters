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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

extension CreateItemView : CreateItemControllerToViewDelegate {
    func updateCountersList() {
        DispatchQueue.main.async {
            self.titleTextfield.text = ""
            self.titleTextfield.endEditing(false)
            self.performSegue(withIdentifier: "unwindToMain", sender: nil)
        }
    }
    
    func showTextFieldLoading() {
        DispatchQueue.main.async {
            self.saveBtn?.isEnabled = false
            self.titleTextfield.activityIndicator(loading: true)
        }
    }
    
    func hideTextFieldLoading() {
        DispatchQueue.main.async {
            self.saveBtn?.isEnabled = true
            self.titleTextfield.activityIndicator(loading: false)
        }
    }
    
    func showDialogError(title: String, message: String, actions : [String:(()->())]){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let sortedActions = actions.sorted() {$0.key > $1.key}
        
        for action in sortedActions {
            let handler : ((UIAlertAction) -> Void) = {_ in
                action.value()
            }
            alert.addAction(UIAlertAction(title: action.key, style: .default, handler: handler))
        }
        
        DispatchQueue.main.async {
            alert.view.tintColor = UIColor(named: "tintColor")
            self.present(alert, animated: true)
        }
    }
}
