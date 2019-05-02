//
//  ViewController.swift
//  Gonzaga News
//
//  Created by Peters, Michael E. on 5/1/19.
//  Copyright © 2019 northw.st. All rights reserved.



import UIKit
import WebKit
import Kanna
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
//    @IBAction func button(_ sender: Any) {
//    }
    var html: String? = nil

    //@IBOutlet weak var tableView: UITableView!
    
    struct ArticleObject { // struct for each article to eventually add interaction with articles
        var title = ""
        var url = ""
    }
    // TESTING STRING OBJECT FOR TABLE VIEW
    //    var items: [String] = [
    //        "a", "b", "c", "d", "e",
    //        ]
    
    
    var articles: [ArticleObject] = [] //array of structs

    override func loadView() {
        super.loadView()
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tableView.topAnchor),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            ])
        self.tableView = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.lightGray
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.dataSource = self
        
//        for name in UIFont.familyNames { // used to find font names in system
//            print(name)
//            if let nameString = name as? String
//            {
//                print(UIFont.fontNames(forFamilyName: nameString))
//            }
//        }
        var header = ArticleObject()
        
        header.title = String("--- Gonzaga News HTML Scraper v1.0 ---")
        self.articles.append(header)
        self.scrapeGonzagaNews()

    }

//    func scrapeGonzagaNews() -> Void {
//        Alamofire.request("https://www.gonzaga.edu/news-events/stories/").responseString { response in
//            print("Success: \(response.result.isSuccess)")
//            self.html = response.result.value
//            //self.parseHTML(response.result.value!)
//
//        }
    func scrapeGonzagaNews() -> Void {
        
        var article = ArticleObject()
        
        Alamofire.request("https://www.gonzaga.edu/news-events/stories/").responseString(queue: nil, encoding: String.Encoding.utf8) { response in
            if let html = response.result.value,
                let doc = try? HTML(html: html, encoding: .utf8) {
                for headline in doc.css(".block-caption h3") {
                    print(String(headline.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)))
                    article.title = String(headline.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                    article.url = ""
                    self.articles.append(article)

                }
                for headline in doc.css(".news-heading") {
                    article.title = String(headline.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                    article.url = ""
                    self.articles.append(article)
                }
                // //*[@id="skipToContent"]/div/article/div/div[2]/div[1]/div/a[2]/figure/img
                // //*[@id="skipToContent"]/div/article/div/div[2]/div[1]/div/a[3]/figure/img
                //
            }
            self.tableView.reloadData()
            print("reloaded1")
            self.scrapeGonzagaNews2()
        }
//        Alamofire.request("https://www.gonzaga.edu/news-events/stories?page=2").responseString(queue: nil, encoding: String.Encoding.utf8) { response in
//            if let html = response.result.value,
//                let doc = try? HTML(html: html, encoding: .utf8) {
//
//                for headline in doc.css(".news-heading") {
//                    article.title = String(headline.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
//                    article.url = ""
//                    self.articles.append(article)
//                }
//            }
//            self.tableView.reloadData()
//            print("reloaded")
//
//
//       }
//        Alamofire.request("https://www.gonzaga.edu/news-events/stories?page=3").responseString(queue: nil, encoding: String.Encoding.utf8) { response in
//            if let html = response.result.value,
//                let doc = try? HTML(html: html, encoding: .utf8) {
//
//                for headline in doc.css(".news-heading") {
//                    article.title = String(headline.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
//                    article.url = ""
//                    self.articles.append(article)
//                }
//            }
//            self.tableView.reloadData()
//            print("reloaded")
        
        
        }
    func scrapeGonzagaNews2() -> Void {
    
        var article = ArticleObject()
        var pageBreak = ArticleObject()
        
        pageBreak.title = "----- Page 2 -----"
        self.articles.append(pageBreak)
        Alamofire.request("https://www.gonzaga.edu/news-events/stories?page=2").responseString(queue: nil, encoding: String.Encoding.utf8) { response in
                        if let html = response.result.value,
                            let doc = try? HTML(html: html, encoding: .utf8) {
            
                            for headline in doc.css(".news-heading") {
                                article.title = String(headline.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                                article.url = ""
                                self.articles.append(article)
                            }
                        }
                        self.tableView.reloadData()
                        print("reloaded2")
                        self.scrapeGonzagaNews3()
            
            
                   }
    }
    func scrapeGonzagaNews3() -> Void {
        
        var article = ArticleObject()
        var pageBreak = ArticleObject()
        
        pageBreak.title = "----- Page 3 -----"
        self.articles.append(pageBreak)
        Alamofire.request("https://www.gonzaga.edu/news-events/stories?page=3").responseString(queue: nil, encoding: String.Encoding.utf8) { response in
                        if let html = response.result.value,
                            let doc = try? HTML(html: html, encoding: .utf8) {
            
                            for headline in doc.css(".news-heading") {
                                article.title = String(headline.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                                article.url = ""
                                self.articles.append(article)
                            }
                        }
                        self.tableView.reloadData()
                        print("reloaded3")
                        self.scrapeGonzagaNews4()
        
    }
    }
    
    func scrapeGonzagaNews4() -> Void {
    
    var article = ArticleObject()
    var pageBreak = ArticleObject()
    
    pageBreak.title = "----- Page 4 -----"
    self.articles.append(pageBreak)
    
    Alamofire.request("https://www.gonzaga.edu/news-events/stories?page=4").responseString(queue: nil, encoding: String.Encoding.utf8) { response in
        if let html = response.result.value,
            let doc = try? HTML(html: html, encoding: .utf8) {
            
            for headline in doc.css(".news-heading") {
                article.title = String(headline.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                article.url = ""
                self.articles.append(article)
            }
        }
        self.tableView.reloadData()
        print("reloaded4")
        
        
    }

}
    
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(self.articles.count)
        return self.articles.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.font = UIFont(name: "FiraCode-Regular", size: 14)
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        let item = self.articles[indexPath.item].title
        cell.textLabel?.text = item
        return cell
    }

}


