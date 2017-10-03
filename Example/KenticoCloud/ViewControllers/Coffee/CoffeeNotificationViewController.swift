//
//  CoffeeNotificationViewController.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 03/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CoffeeNotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Properties
    
    var coffee: Coffee!
    
    @IBOutlet var dismissButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var price: UILabel!
    @IBOutlet var farm: UILabel!
    @IBOutlet var variety: UILabel!
    @IBOutlet var processing: UILabel!
    @IBOutlet var altitude: UILabel!
    @IBOutlet var coffeeImage: UIImageView!
    
    // MARK: VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dismissButton.stylePinkButton()
        
        setContent(coffee: self.coffee)
    }
    
    // MARK: Table delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeDescriptionCell") as! CoffeeDescriptionViewCell
        cell.coffeeDescription.styleWithRichtextString(richtextString: (coffee.longDescription?.htmlContentString)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1000
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    // MARK: Outlet actions
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func setContent(coffee: Coffee) {
        
        if let price = coffee.price?.value {
            self.price.text = "$\(price) / 1lb"
        }
        self.farm.text = coffee.farm?.value
        
        self.variety.text = coffee.variety?.value
        
        if !((coffee.processing?.value?.isEmpty)!) {
            if let processingTechnique = coffee.processing?.value?[0].name {
                self.processing.text = processingTechnique
            }
        }
        
        if let altitude = coffee.altitude?.value {
            self.altitude.text = "\(altitude) ft"
        }
        
        if let imageUrl = coffee.photo?.value?[0].url {
            let url = URL(string: imageUrl)
            coffeeImage.af_setImage(withURL: url!)
        }
    }
}
