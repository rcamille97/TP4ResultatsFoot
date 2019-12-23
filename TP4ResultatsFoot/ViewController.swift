//
//  ViewController.swift
//  TP4ResultatsFoot
//
//  Created by Camille on 24/10/2019.
//  Copyright © 2019 Camille Rubio. All rights reserved.
//

import UIKit

//TODO:: prevent screen to rotate


class ViewController: UIViewController, UITableViewDataSource {
    
    var path : String?
    var jsonResult : [String:AnyObject] = [:]
    var results : NSArray = []
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Résultats des matchs"
        self.setDataFromAPIToJSON()
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(Cell.self, forCellReuseIdentifier: "Default")
        self.view.addSubview(tableView)
        
    }

    func setDataFromAPIToJSON(){
        var  myJSONParsed : [String:AnyObject] = [:]
        if let url = URL(string: "http://mathieu.goodbarber.com/docs/scb_resultats.json") {
            let data:NSData = try! NSData(contentsOf: url as URL)
            do {
                myJSONParsed = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! [String:AnyObject]
                self.results = myJSONParsed["resultats"] as! NSArray
            } catch let error as NSError {
                print(error)
            }
        }
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath) as! Cell
        
        let r1 = results[indexPath.row] as! [String:AnyObject]
        
        //Utilisation de l'extension de l'UIImageView pour gérer le téléchargement de l'image
        cell.domLogo.loadImageUsingCacheWithURLString((r1["dom_logo_url"] as! String), placeHolder: UIImage(named: "nologo.png" )){ (bool) in
        }
        
        cell.extLogo.loadImageUsingCacheWithURLString((r1["ext_logo_url"] as! String), placeHolder: UIImage(named: "nologo.png" )){ (bool) in
        }

        cell.dateLabel.text = r1["date"] as! String
        cell.domLabel.text = r1["dom_name"] as! String
        cell.extLabel.text = r1["ext_name"] as! String
        
        if r1["score"] as! String == ""{
             cell.scoreLabel.text = "-"
        }else{
            cell.scoreLabel.text = r1["score"] as! String
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
}

