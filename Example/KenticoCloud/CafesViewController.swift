//
//  CafesViewController.swift
//  KenticoCloud
//
//  Created by martinmakarsky@gmail.com on 08/16/2017.
//  Copyright (c) 2017 martinmakarsky@gmail.com. All rights reserved.
//

import UIKit
import KenticoCloud
import AlamofireImage

class CafesViewController: UIViewController, UITableViewDataSource {

    private let projectId = "adcae48f-b42b-4a53-a8fc-b3b4501561b9"
    private let type = "cafe"
    
    @IBOutlet var tableView: UITableView!
    private var cafes: [Cafe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCafes()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cafeCell") as! CafeTableViewCell
        
        let cafe = cafes[indexPath.row]
        cell.city.text = cafe.city
        cell.firstRowAddress.text = cafe.street
        cell.secondRowAddress.text = cafe.state
        cell.phone.text = cafe.phone
        
        if let imageUrl = cafe.imageUrl {
            let url = URL(string: imageUrl)
            cell.photo.af_setImage(withURL: url!)
        }

        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cafeDetailSegue" {
            
            let cafeDetailViewController = segue.destination
                as! CafeDetailViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            cafeDetailViewController.cafe = cafes[indexPath.row]
            
            let cell = self.tableView.cellForRow(at: indexPath) as! CafeTableViewCell
            cafeDetailViewController.image = cell.photo.image
        }
    }
    
    @IBAction func showMenu(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    
    private func getCafes() {
        let cloudClient = Client.init(projectId: projectId)
        cloudClient.fetchItems(contentType: type, modelType: Cafe.self) { (isSuccess, items) in
            if isSuccess {
                if let cafes = items {
                    self.cafes = cafes
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

