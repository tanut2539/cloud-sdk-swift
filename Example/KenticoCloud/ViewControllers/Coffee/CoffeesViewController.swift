//
//  CoffeeViewController.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 31/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import KenticoCloud

class CoffeesViewController: UIViewController, UITableViewDataSource {
    
    private let contentType = "coffee"
    private var coffees: [Coffee] = []
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.insertSubview(refreshControl!, at: 0)
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
        
        getCoffees()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeCell") as! CoffeeTableViewCell
        
        let coffee = coffees[indexPath.row]
        cell.title.text = coffee.name?.value
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "coffeeDetailSegue" {
            
            let coffeeDetailViewController = segue.destination
                as! CoffeeDetailViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            coffeeDetailViewController.coffee = coffees[indexPath.row]
            
            _ = self.tableView.cellForRow(at: indexPath) as! CoffeeTableViewCell
        }
    }
    
    @IBAction func showMenu(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    
    @IBAction func refreshTable(_ sender: Any) {
        getCoffees()
    }
    
    private func getCoffees() {
        let cloudClient = DeliveryClient.init(projectId: "84ebeafd-cad0-47e5-811a-789df7a43ad0")
        
        let contentTypeQueryParameter = QueryParameter.init(parameterKey: QueryParameterKey.type, parameterValue: contentType)
        let coffeesQueryParameters = [contentTypeQueryParameter]
        
        do {
            try cloudClient.getItems(modelType: Coffee.self, queryParameters: coffeesQueryParameters) { (isSuccess, items, error) in
                if isSuccess {
                    if let cofees = items {
                        self.coffees = cofees
                        self.tableView.reloadData()
                    }
                } else {
                    if let error = error {
                        print(error)
                    }
                }
                
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            } 
        } catch {
            print("Error info: \(error)")
        }
    }
    
}
