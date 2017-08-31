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

    override func viewDidLoad() {
        super.viewDidLoad()
        getCoffees()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getCoffees() {
        let cloudClient = Client.init(projectId: AppConstants.projectId, apiKey: AppConstants.kenticoCloudApiKey)
        cloudClient.getItems(contentType: contentType, modelType: Coffee.self, isPreview: AppConstants.isPreview) { (isSuccess, items) in
            if isSuccess {
                if let cofees = items {
                    print(cofees)
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeCell")!
        return cell
    }

}
