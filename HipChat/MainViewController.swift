//
//  ViewController.swift
//  HipChat
//
//  Created by Sasha Sheng on 5/9/15.
//  Copyright (c) 2015 Sasha Sheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: center the locations
        self.view.backgroundColor = UIColor.darkGrayColor();
        
        var myTextField: UITextField = UITextField(frame: CGRect(x: 40, y: 250, width: 300.00, height: 40.00));
        myTextField.placeholder = "What's your nickname?";
        myTextField.layer.cornerRadius = 2.0;
        myTextField.textColor = UIColor.whiteColor();
        
        var underline: UIView = UIView(frame: CGRect(x: 40, y: 292, width: 300.00, height: 2.00));
        underline.backgroundColor = UIColor.whiteColor();
        underline.layer.cornerRadius = 2.0;
        
        var loginButton: UIButton = UIButton(frame: CGRect(x:40, y:308, width: 300.00, height: 40.00));
        loginButton.backgroundColor = UIColor.grayColor();
        loginButton.layer.cornerRadius = 4.0;
        loginButton.setTitle("Login", forState:(UIControlState.Normal));
        loginButton.addTarget(self, action: "loginTapped:", forControlEvents: UIControlEvents.TouchUpInside);
        
        
        self.view.addSubview(underline);
        self.view.addSubview(myTextField);
        self.view.addSubview(loginButton);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginTapped(button: UIButton) {
        var hipViewController: HipChatRoomViewController = HipChatRoomViewController();
        self.presentViewController(hipViewController, animated: true) { () -> Void in
            
        }
    }
}
