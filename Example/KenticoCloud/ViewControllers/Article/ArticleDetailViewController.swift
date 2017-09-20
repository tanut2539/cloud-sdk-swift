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
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let body = article?.bodyCopy?.htmlContentString {
            do {
                let str = try NSAttributedString(data: body.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
                textView.attributedText = str
            } catch {
                print(error)
            }
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
