//
//  SettingsViewController.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 13/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet var settingsTable: UITableView!
    @IBOutlet weak var languageSelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showMenu(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    
}
