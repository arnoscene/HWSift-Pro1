//
//  DetailViewController.swift
//  project7
//
//  Created by Charnold on 02/09/2015.
//  Copyright (c) 2015 Arnold. All rights reserved.
//

import UIKit
import WebKit


class DetailViewController: UIViewController {

    

    var detailItem: [String: String]!
    var webView: WKWebView!
    
    override func loadView() {
        
        webView = WKWebView()
        self.view = webView
    }
    
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        if let body = detailItem["body"]{
            var html = "<html>"
            html += "<head>"
            html += "<meta name =\"viewport\"content=\"width=device-width,intial-scale = 1\">"
            html += "<style> body {font-size: 110%;} </style>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            
            webView.loadHTMLString(html, baseURL: nil)
            
        }
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

