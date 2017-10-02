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

class ArticlesViewController: ListingBaseViewController, UITableViewDataSource {
    
    // MARK: Properties
    
    private let contentType = "article"
    private var articles: [Article] = []
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var refreshControl: UIRefreshControl!
    
    // MARK: VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        if articles.count == 0 {
            getArticles()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Table delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as! ArticleTableViewCell
        cell.photo.addBorder()
        
        let article = articles[indexPath.row]
        cell.title.text = article.title?.value
        cell.summary.text = article.summary?.value
        
        if let date = article.postDate?.value {
            cell.date.text = date.getDateString()
        }
        
        if let imageUrl = article.asset?.value?[0].url {
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
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: Outlet actions
    
    @IBAction func refreshTable(_ sender: Any) {
        getArticles()
    }
    
    // MARK: Getting items
    
    private func getArticles() {
        self.showLoader(message: "Loading articles...")
        
        let cloudClient = DeliveryClient.init(projectId: AppConstants.projectId)
        let customQuery = "items?system.type=article&order=elements.post_date[desc]"
        
        cloudClient.getItems(modelType: Article.self, customQuery: customQuery) { (isSuccess, itemsResponse, error) in
            if isSuccess {
                if let articles = itemsResponse?.items {
                    self.articles = articles
                    self.tableView.reloadData()
                }
            } else {
                if let error = error {
                    print(error)
                }
            }
            
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            
            self.hideLoader()
        }
    }
    
}

