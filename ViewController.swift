//
//  ViewController.swift
//  TrendChecker2
//
//  Created by user on 2020/01/20.
//  Copyright © 2020 dd. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var TableViewMain: UITableView!
    var keyWordData : Array<Dictionary<String,Any>>?
      
      func getKeyWord() {
          let task = URLSession.shared.dataTask(with: URL(string:"https://newsapi.org/v2/top-headlines?country=kr&apiKey=fe0879a26b144ea5b953dde899d874df")!) { (data,response, error) in
          
          
          if let dataJson = data {
              
          
        
              do{
              let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String,Any>
             let articles = json["articles"] as! Array<Dictionary<String,Any>>
                  self.keyWordData = articles
                  DispatchQueue.main.async {
                      self.TableViewMain.reloadData()
                  }
               
             
              
              }
              catch{}
              }
              
          }
          task.resume()
      }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if let keywords = keyWordData {
                  return keywords.count
              }
              else {
                  return 0
              }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "List1", for:indexPath ) as! List1
     let idx = indexPath.row
            if let keywords = keyWordData {
                let row = keywords[idx]
            if let v = row as? Dictionary<String,Any> {
               print("TITLE :: \(v)")
                if let title = v["title"] as? String{
                    cell.KeyWordList.text = title
                }
                }
            }
        
        return cell
    }
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICK !!! \(indexPath.row)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        getKeyWord()
        
    }


}

