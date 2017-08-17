//
//  ArticlesViewController.swift
//  KenticoCloud
//
//  Created by martinmakarsky@gmail.com on 08/16/2017.
//  Copyright (c) 2017 martinmakarsky@gmail.com. All rights reserved.
//

import UIKit
import KenticoCloud
import AlamofireImage

class ArticlesViewController: UIViewController, UITableViewDataSource {
    
    private let projectId = "adcae48f-b42b-4a53-a8fc-b3b4501561b9"
    private let type = "article"
    
    @IBOutlet var tableView: UITableView!
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getArticles()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
        
        let article = articles[indexPath.row]
        cell.title.text = article.title
        cell.summary.text = article.summary
        
        if let imageUrl = article.imageUrl {
            let url = URL(string: imageUrl)
            cell.photo.af_setImage(withURL: url!)
        }
        
        
        return cell
    }
    
    @IBAction func showMenu(_ sender: Any) {
        panel?.openLeft(animated: true)
    }

    private func getArticles() {
        let cloudClient = Client.init(projectId: projectId)
        cloudClient.fetchItems(contentType: type, modelType: Article.self) { (isSuccess, items) in
            if isSuccess {
                if let articles = items {
                    self.articles = articles
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

