//
//  ViewController.swift
//  KenticoCloud
//
//  Created by martinmakarsky@gmail.com on 08/16/2017.
//  Copyright (c) 2017 martinmakarsky@gmail.com. All rights reserved.
//

import UIKit
import KenticoCloud

class ViewController: UIViewController {

    private let projectId = "adcae48f-b42b-4a53-a8fc-b3b4501561b9"
    private let type = "cafe"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cloudClient = Client.init(projectId: projectId)
        let result = cloudClient.fetchItems(contentType: type)
        print(result)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

