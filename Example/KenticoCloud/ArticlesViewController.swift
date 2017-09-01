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
    
    private let contentType = "article"
    
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
        let postdate = article.postDate
        cell.date.text = postdate?.substring(to:(postdate?.index((postdate?.startIndex)!, offsetBy: 10))!)
        
        if let imageUrl = article.imageUrl {
            let url = URL(string: imageUrl)
            cell.photo.af_setImage(withURL: url!)
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleDetailSegue" {
            
            let articleDetailViewController = segue.destination
                as! ArticleDetailViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            articleDetailViewController.article = articles[indexPath.row]
            
            let cell = self.tableView.cellForRow(at: indexPath) as! ArticleTableViewCell
            articleDetailViewController.image = cell.photo.image!
        }
    }
    
    @IBAction func showMenu(_ sender: Any) {
        panel?.openLeft(animated: true)
    }
    
    private func getArticles() {
        let cloudClient = Client.init(projectId: AppConstants.projectId, apiKey: AppConstants.kenticoCloudApiKey)
        let articlesQuery = ItemsQuery.init(endpoint: AppConstants.endpoint, contentType: contentType)
        cloudClient.getItems(query: articlesQuery, modelType: Article.self) { (isSuccess, items) in
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

