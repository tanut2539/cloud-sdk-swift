//
//  CoffeeDetailViewController.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 31/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class CoffeeDetailViewController: UIViewController {
    @IBOutlet var coffeeDescription: UITextView!
    @IBOutlet var price: UILabel!
    @IBOutlet var farm: UILabel!
    @IBOutlet var variety: UILabel!
    @IBOutlet var processing: UILabel!
    @IBOutlet var altitude: UILabel!
    @IBOutlet var coffeeImage: UIImageView!
    
    var coffee: Coffee!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
}
