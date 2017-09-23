//
//  CoffeeDetailViewController.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 31/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import  KenticoCloud

class CoffeeDetailViewController: UIViewController {
    @IBOutlet var coffeeDescription: UITextView!
    @IBOutlet var price: UILabel!
    @IBOutlet var farm: UILabel!
    @IBOutlet var variety: UILabel!
    @IBOutlet var processing: UILabel!
    @IBOutlet var altitude: UILabel!
    @IBOutlet var coffeeImage: UIImageView!
    @IBOutlet var callToActionButton: UIButton!
    
    var coffee: Coffee!
    private var callToAction: CallToAction?
    private var selectedCafes: SelectedCafes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callToActionButton.isHidden = true
        if let callToActionNames = coffee.callToActions?.value {
            getCoffeeEnthusiastCta(callToActionNames: callToActionNames)
        }
        
        self.title = coffee.name?.value
        if let description = coffee.longDescription?.htmlContentString {
            do {
                let attributedString = try NSAttributedString(data: description.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
                coffeeDescription.attributedText = attributedString
            } catch {
                print(error)
            }
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "coffeeDetailCtaSegue" {
            
            let coffeeDetailCtaViewController = segue.destination
                as! CoffeeDetailCallToActionViewController
            
            coffeeDetailCtaViewController.callToAction = callToAction
            coffeeDetailCtaViewController.selectedCafes = selectedCafes
        }
    }
    
    
    // Get Call to Action for Coffee enthusiast persona only
    private func getCoffeeEnthusiastCta(callToActionNames: [String?]) {
        
        for callToActionName in callToActionNames {
            if let ctoName = callToActionName {
                let client = DeliveryClient.init(projectId: AppConstants.projectId)
                client.getItem(modelType: CallToAction.self, itemName: ctoName, completionHandler: {isSuccess, deliveryItem, error in
                    if isSuccess {
                        if let cto = deliveryItem?.item {
                            if (cto.persona?.containsName(name: "Coffee enthusiast"))! {
                                self.callToAction = cto
                                self.showCallToAction()
                            }
                        }
                    } else {
                        print("Error while getting CTOs. Error: \(String(describing: error))")
                    }
                })
            }
        }
        
        let client = DeliveryClient.init(projectId: AppConstants.projectId)
        client.getItem(modelType: SelectedCafes.self, itemName: "cafes_in_your_area", completionHandler: {isSuccess, deliveryItem, error in
            if isSuccess {
                if let selectedCafes = deliveryItem?.item {
                    self.selectedCafes = selectedCafes
                    self.showCallToAction()
                }
            } else {
                print("Error while getting CTOs. Error: \(String(describing: error))")
            }
        })
    }
    
    private func showCallToAction() {
        if let titleText = self.callToAction?.actionButtonText?.value {
            if selectedCafes != nil {
                callToActionButton.setTitle(titleText, for: .normal)
                callToActionButton.isHidden = false
            }
        }
    }
}
