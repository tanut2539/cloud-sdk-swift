//
//  NotificationCafeViewController.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 23/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import KenticoCloud
import AlamofireImage
import MapKit

class NotificationCafeViewController: UIViewController {
    
    var cafeName: String?
    var cafe: Cafe?
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var firstRowAddress: UILabel!
    @IBOutlet weak var secondRowAddress: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var map: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cafeName = cafeName {
            getCafe(name: cafeName)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    private func setTitles(cafe: Cafe) {
        title = cafe.city
        city.text = cafe.city
        firstRowAddress.text = cafe.street
        secondRowAddress.text = cafe.state
        phone.text = cafe.phone
    }
    
    private func setMap(cafe: Cafe) {
        let address = "\(cafe.street ?? "")  \(cafe.state ?? "") \(cafe.country ?? "")  \(cafe.zip ?? "")"
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            
            let pinPoint = MKPointAnnotation()
            pinPoint.coordinate = location.coordinate
            print(location.coordinate)
            self.map?.addAnnotation(pinPoint)
            
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            self.map?.setRegion(region, animated: true)
        }
    }
    
    private func setImages(url: String) {
        if (photo) != nil {
            self.photo.af_setImage(withURL: URL(string: url)!)
        }
    }
    
    private func getCafe(name: String) {
        let cloudClient = Client.init(projectId: AppConstants.projectId, apiKey: AppConstants.kenticoCloudApiKey)
        
        do {
            try cloudClient.getItem(modelType: Cafe.self, itemName: name) { (isSuccess, item) in
                if isSuccess {
                    if let cafe = item {
                        self.cafe = cafe
                        self.setTitles(cafe: cafe)
                        self.setMap(cafe: cafe)
                        self.setImages(url: cafe.imageUrl!)
                    }
                }
            }
        } catch {
            print("Error info: \(error)")
        }
    }
    
    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
