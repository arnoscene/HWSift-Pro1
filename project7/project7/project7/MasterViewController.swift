//
//  MasterViewController.swift
//  project7
//
//  Created by Charnold on 02/09/2015.
//  Copyright (c) 2015 Arnold. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [[String: String]]()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                        
        var urlString: String
        
        if(navigationController?.tabBarItem.tag == 0){
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        }else{
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"

        }

        
        if let url = NSURL(string: urlString){
            if let data = NSData(contentsOfURL: url, options: .allZeros, error: nil){
                let json = JSON(data: data)
                
                if json["metadata"]["responseInfo"]["status"].intValue == 200{
                    
                    parseJSON(json)
                }else{
                    showEorr()
                }
            }else{
                showEorr()
            }
        }else{
            showEorr()
        }
        
    }
    
    func showEorr(){
        let ac = UIAlertController(title: "Error", message: "Soemthing broke you need to go back and code it", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        
    }
    
    func parseJSON(json: JSON){
        
        for result in json["results"].arrayValue{
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            
            let dict = ["title": title , "body": body, "sigs": sigs]
            objects.append(dict)

        }
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row]
            (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let object = objects[indexPath.row]
        cell.textLabel!.text = object["title"]
        cell.detailTextLabel!.text = object["sigs"]
        return cell
    }




}

