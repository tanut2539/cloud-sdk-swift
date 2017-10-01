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

class CafesViewController: ListingBaseViewController, UITableViewDataSource {
    
    private let contentType = "cafe"
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var refreshControl: UIRefreshControl!
    
    var cafes: [Cafe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.insertSubview(refreshControl!, at: 0)
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
        
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
        cell.cafeTitle.text = cafe.city
        cell.cafeSubtitle.text = "\(cafe.street ?? "") \(cafe.phone ?? "")"
        
        if let imageUrl = cafe.imageUrl {
            let url = URL(string: imageUrl)
            cell.photo.af_setImage(withURL: url!)
            cell.photo.layer.borderColor = AppConstants.imageBorderColor.cgColor
            cell.photo.layer.borderWidth = 2
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
    
    @IBAction func refreshTable(_ sender: Any) {
        getCafes()
    }
    
    private func getCafes() {
        self.showLoader(message: "Loading cafes...")
        
        let cloudClient = DeliveryClient.init(projectId: AppConstants.projectId)
        
        let typeQueryParameter = QueryParameter.init(parameterKey: QueryParameterKey.type, parameterValue: contentType)
        let cafesQueryParameters = [typeQueryParameter]
        
        cloudClient.getItems(modelType: Cafe.self, queryParameters: cafesQueryParameters) { (isSuccess, itemsResponse, error) in
            if isSuccess {
                if let cafes = itemsResponse?.items {
                    self.cafes = cafes
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
            
            self.hideLoader()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

