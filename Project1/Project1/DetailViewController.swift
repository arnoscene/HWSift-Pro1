//
//  DetailViewController.swift
//  project1
//
//  Created by Charnold on 24/08/2015.
//  Copyright (c) 2015 Arnold. All rights reserved.
//

import Social
import UIKit

class DetailViewController: UIViewController {



    @IBOutlet weak var detailImageView: UIImageView!

    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let imageView = detailImageView {
                imageView.image = UIImage(named:detail)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "shareTapped")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    func shareTapped(){
//        let activity = UIActivityViewController(activityItems: [detailImageView.image!], applicationActivities: [])
//        presentViewController(activity, animated: true, completion: nil)
        
        let social = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        social.setInitialText("Hello world, buy my app")
        social.addImage(detailImageView.image!)
        social.addURL(NSURL(string: "http://www.photolib.noaa.gov/nssl"))
        presentViewController(social, animated: true, completion: nil)
        
//        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
//        vc.se
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

