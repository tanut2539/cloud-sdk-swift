//
//  ArticleDetailViewController.swift
//  KenticoCloud
//
//  Created by Martin Makarsky on 21/08/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    var article: Article?
    var image: UIImage?
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let body = article?.bodyCopy?.htmlContentString {
            webView.loadHTMLString(body , baseURL: nil)
        }
        
        if let image = image {
            titleImage.image = image
        }
        
        if let article = article{
            self.articleTitle.text = article.title?.value
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
