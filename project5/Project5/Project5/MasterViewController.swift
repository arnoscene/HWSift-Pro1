//
//  MasterViewController.swift
//  Project5
//
//  Created by Charnold on 01/09/2015.
//  Copyright (c) 2015 Arnold. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [String]()
    var allWords = [String]()


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let startWordsPath = NSBundle.mainBundle().pathForResource("start", ofType: "txt"){
            
            if let startWords = NSString(contentsOfFile: startWordsPath, usedEncoding: nil, error: nil){
                allWords = startWords.componentsSeparatedByString("\n") as! [String]
            }
        }else{
            allWords = ["silkworm"]
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "promptForAnswer")
        
        startGame()
        
    }
    
    func startGame(){
        allWords.shuffle()
        title = allWords[0]
        objects.removeAll(keepCapacity: true)
        tableView.reloadData()
        
    }
    
    func promptForAnswer(){
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler(nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default){ [unowned self, ac] action in
            let answer = ac.textFields![0] as! UITextField
            self.submitAnswer(answer.text)
           }
        
        ac.addAction(submitAction)
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func submitAnswer(answer: String){
        let lowerAnswer = answer.lowercaseString
        
        if wordIsPossible(lowerAnswer){
            if wordIsOrginal(lowerAnswer){
                if wordIsReal(lowerAnswer){
                    objects.insert(answer, atIndex: 0)
                    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    
                    
                }
            }
            
        }
    }
    
    func wordIsPossible(word: String) -> Bool{
        return true
    }
    
    func wordIsOrginal(word: String) -> Bool{
        return !contains(objects, word)
    }
    
    func wordIsReal(word: String) -> Bool{
        return true
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.textLabel!.text = object
        return cell
    }

   


}

