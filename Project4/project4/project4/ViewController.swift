//
//  ViewController.swift
//  project4
//
//  Created by Charnold on 31/08/2015.
//  Copyright (c) 2015 Arnold. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["liveleak.com","appstorius.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view = webView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "http://"+websites[0])!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true

        progressView = UIProgressView(progressViewStyle: .Default)
        progressView.sizeToFit()
        progressView.progress = 0.5
        
        let progressButton = UIBarButtonItem(customView: progressView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action:"openTapped")
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: webView, action: "reload")
        
        toolbarItems = [progressButton,spacer,refresh]
        
        navigationController?.toolbarHidden = false
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openTapped(){
        let ac = UIAlertController(title: "Open page", message: nil, preferredStyle: .ActionSheet)
        
        for website in websites{
            ac.addAction(UIAlertAction(title: website, style: .Default, handler: openPage))
            
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)

    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>){
        
        if keyPath == "estimatedProgress"{0
            
            progressView.progress = Float(webView.estimatedProgress)
        
        }
        
    }
    
    func openPage(action: UIAlertAction!){
        
        let url = NSURL(string: "http://" + action.title)!
        webView.loadRequest(NSURLRequest(URL: url))
        
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.URL
        
        if let host = url?.host{
            for website in websites{
                if host.rangeOfString(website) != nil {
                    decisionHandler(.Allow)
                    return
                }
            }
        }
        
        decisionHandler(.Cancel)
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        title=webView.title
    }


}

