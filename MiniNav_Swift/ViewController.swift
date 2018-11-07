//
//  ViewController.swift
//  MiniNav_Swift
//
//  Created by TA Trung Thanh on 06/11/2018.
//  Copyright © 2018 TA Trung Thanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let v = myView(frame: .zero)
    private let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    
    private let alertActionGoHome = UIAlertController(title: "Go home", message: "Do you confirm?", preferredStyle: .actionSheet)
    
    private let alertNewURL = UIAlertController(title: "URL", message: "Enter new URL:", preferredStyle: .alert)
    private var alertNewURLAnswer : UITextField?
    
    private let alertNewHome = UIAlertController(title: "New home", message: "Enter new home:", preferredStyle: .alert)
    private var alertNewHomeAnswer : UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view = v
        v.drawInFormat(format: UIScreen.main.bounds.size)
        
        //The Go Home alert
        alertActionGoHome.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: loadHome))
        alertActionGoHome.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        //The new URL alert
        alertNewURL.addTextField(configurationHandler: {thisTextField -> Void in
            //Customize the alert newURL
            thisTextField.textColor = UIColor.blue
            thisTextField.text = "https://" //to avoid write a lot of text
            //Stock in private variable
            self.alertNewURLAnswer = thisTextField
        })
        alertNewURL.addAction(UIAlertAction(title: "Ok", style: .default, handler: readURL))
        alertNewURL.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        //The new home alert
        alertNewHome.addTextField(configurationHandler: {thisTextField -> Void in
            //Customize the alert newURL
            thisTextField.textColor = UIColor.blue
            thisTextField.text = "https://" //to avoid write a lot of text
            //Stock in private variable
            self.alertNewHomeAnswer = thisTextField
        })
        alertNewHome.addAction(UIAlertAction(title: "Ok", style: .default, handler: setNewHome))
        alertNewHome.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let v = self.view as! myView
        v.drawInFormat(format: size)
    }
    
    //backward and forward
    @objc func goToOtherPage(sender: UIBarButtonItem){
        if sender == v.outletRewind {
            v.goBack()
        } else {
            v.goForward()
        }
    }
    
    //Trigger the alert box
    @objc func alert_newURL(){
        self.present(alertNewURL, animated: true, completion: {})
    }
    @objc func alert_newHome(){
        self.present(alertNewHome, animated: true, completion: {})
    }
    @objc func alert_goHome(){
        self.present(alertActionGoHome, animated: true, completion: {})
    }
    
    
    //Get the information in the box to construit new URL
    @objc func readURL(sender: UIAlertAction){
        let v = self.view as! myView
        v.loadURL(url: (alertNewURLAnswer?.text!)!)
    }
    
    //Get the new URL and set it to new Home
    @objc func setNewHome(sender: UIAlertAction){
        let v = self.view as! myView
        v.setURLHome(url: (alertNewHomeAnswer?.text!)!)
    }
    /*
    @objc func goHome(sender: UIAlertAction) {
        if isIpad {
            alertActionGoHome.modalPresentationStyle = .popover
            alertActionGoHome.popoverPresentationController?.barButtonItem = v.outletGoHome
        }
        self.present(alertActionGoHome, animated: true, completion: {})
    }
    */
    func loadHome(sender: UIAlertAction) {
        v.loadHome()
    }
    
}
