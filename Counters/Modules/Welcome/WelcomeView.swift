//
//  WelcomeView.swift
//  Counters
//
//  Created by Samuel García on 27-07-20.
//  Copyright © 2020 Samuel García. All rights reserved.
//

import UIKit

class WelcomeView: UIViewController {
    
    var welcomeArray : [WelcomeModel] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "WelcomeTableViewCell", bundle: nil), forCellReuseIdentifier: "WelcomeTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fillWelcomeArray()
        
        tableView.reloadData()
    }
    
    func fillWelcomeArray() {
        welcomeArray.append(WelcomeModel(title: "Add almost anything", description: "Capture cups of lattes, frapuccinos, or anything else that can be counted.", iconName: "first-welcome-icon", backgroundColor: UIColor.hexStringToUIColor(hex: "#FF3B30")))
        welcomeArray.append(WelcomeModel(title: "Count to self, or with anyone", description: "Others can view or make changes. There’s no authentication API.", iconName: "second-welcome-icon", backgroundColor: UIColor.hexStringToUIColor(hex: "#FFCC00")))
        welcomeArray.append(WelcomeModel(title: "Count your thoughts", description: "Possibilities are literally endless.", iconName: "third-welcome-icon", backgroundColor: UIColor.hexStringToUIColor(hex: "#4CD964")))
    }
    
    @IBAction func `continue`(_ sender: Any) {
        Cache.shared.saveFirstLoad()
        dismiss(animated: true)
    }
    
}

extension WelcomeView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        welcomeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WelcomeTableViewCell", for: indexPath) as? WelcomeTableViewCell {
            cell.configure(welcomeArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
