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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return coffees.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fist cell is header static one
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeHeaderCell")!
            return cell
        }
        
        // Normal prototype coffee cell
        if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeCell") as! CoffeeTableViewCell
            
            let coffee = coffees[indexPath.row]
            cell.title.text = coffee.name?.value
            cell.coffeeDescription.text = coffee.shortDescription?.value
            if let price = coffee.price?.value {
                cell.price.text = "$ \(price) / 1lb"
            }
            
            if !((coffee.processing?.value?.isEmpty)!) {
                if let processingTechnique = coffee.processing?.value?[0].name {
                    cell.processing.text = processingTechnique
                }
            }
            
            if let imageUrl = coffee.photo?.value?[0].url {
                let url = URL(string: imageUrl)
                cell.photo.af_setImage(withURL: url!)
            }
            
            if (coffee.promotion?.containsCodename(codename: "featured"))! {
                cell.featured.isHidden = false
            } else {
                cell.featured.isHidden = true
            }
            
            return cell
        }
        
        // Default should never happen
        let cell = UITableViewCell.init()
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
    
    @IBAction func refreshTable(_ sender: Any) {
        getCoffees()
    }
    
    private func getCoffees() {
        let cloudClient = DeliveryClient.init(projectId: AppConstants.projectId)
        
        let contentTypeQueryParameter = QueryParameter.init(parameterKey: QueryParameterKey.type, parameterValue: contentType)
        let coffeesQueryParameters = [contentTypeQueryParameter]
        
        cloudClient.getItems(modelType: Coffee.self, queryParameters: coffeesQueryParameters) { (isSuccess, itemsResponse, error) in
            if isSuccess {
                if let coffees = itemsResponse?.items {
                    self.coffees = coffees.sorted { ($0.promotion!.containsCodename(codename: "featured")) && (!$1.promotion!.containsCodename(codename: "featured")) }
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
    }
    
}
