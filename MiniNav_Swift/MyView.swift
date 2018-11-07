//
//  MyView.swift
//  MiniNav_Swift
//
//  Created by TA Trung Thanh on 06/11/2018.
//  Copyright © 2018 TA Trung Thanh. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class myView: UIView, WKNavigationDelegate, WKUIDelegate {
    
    private let toolbar = UIToolbar();
    let outletGoHome = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)
    let outletForward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: nil, action: nil)
    let outletRewind = UIBarButtonItem(barButtonSystemItem: .rewind, target: nil, action: nil)
    let outletChangeHome = UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
    let outletGo = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
    
    private var urlHome = "https://pagesperso.lip6.fr/Fabrice.Kordon/"
    private var myWebView : WKWebView!

    override init(frame: CGRect) {
        //toolBar config
        let espace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        espace.width=20
        let varEspace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace ,target: nil, action: nil)
        toolbar.items = [outletGoHome,varEspace,outletRewind,espace,outletGo,espace,outletForward,varEspace,outletChangeHome]
        //WebKit config
        myWebView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        
        //seulement apres cette instruction le SELF existe
        super.init(frame: frame)
        self.addSubview(toolbar)
        self.addSubview(myWebView)
        
        myWebView.navigationDelegate = self
        myWebView.uiDelegate = self
        
        outletRewind.target = self.superview
        outletRewind.action = #selector(ViewController.goToOtherPage)
        outletForward.target = self.superview
        outletForward.action = #selector(ViewController.goToOtherPage)
        
        outletGoHome.target = self.superview
        outletGoHome.action = #selector(ViewController.alert_goHome)
        outletGo.target = self.superview
        outletGo.action = #selector(ViewController.alert_newURL)
        outletChangeHome.target = self.superview
        outletChangeHome.action = #selector(ViewController.alert_newHome)
        
        //Load URL
        self.loadURL(url: "https://google.com")
        //draw the view
        self.drawInFormat(format: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("WTF???")
    }
    
    func drawInFormat(format:CGSize) {
        let top=20
        let tbar=44
        toolbar.frame = CGRect(x: 0, y: top, width: Int(format.width), height:tbar)
        myWebView.frame = CGRect(x: 0, y: top+tbar, width: Int(format.width), height: Int(format.height))
    }
    
    func loadURL(url: String) {
        myWebView.load(URLRequest(url:URL(string: url)!))
    }

    @objc func loadHome(){
        NSLog("loadHome")
        loadURL(url: urlHome)
    }
    
    func setURLHome(url: String){
        NSLog("set new Home")
        urlHome = url
        NSLog(urlHome)
    }
    
    func checkNavButton() {
        if myWebView.canGoForward {
            outletForward.isEnabled = true
        } else {
            outletForward.isEnabled = false
        }
        if myWebView.canGoBack {
            outletRewind.isEnabled = true
        } else {
            outletRewind.isEnabled = false
        }
    }
    
    @objc func goBack(){
        NSLog("goBack")
        myWebView.goBack()
        self.setNeedsDisplay()
    }
    
    @objc func goForward(){
        NSLog("goForward")
        myWebView.goForward()
        self.setNeedsDisplay()
    }
    
    //WKNavigationDelegate protocol
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        NSLog(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        let url = URL(string: webView.url!.absoluteString) //new redirected string
        if url != nil {
            let request = URLRequest(url: url!)
            myWebView.load(request)
        } else {
            NSLog("Bad direction!")
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let t = webView.title
        if t != nil {
            NSLog("New page loaded!")
        }
        self.checkNavButton()
    }
}
