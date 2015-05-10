//
//  HipChatRoomViewController.swift
//  HipChat
//
//  Created by Sasha Sheng on 5/9/15.
//  Copyright (c) 2015 Sasha Sheng. All rights reserved.
//

import UIKit
import CoreMotion

let SIDE_THRESHOLD = 3.0;
let FRONT_THRESHOLD = 2.0;
let BACK_THRESHOLD = 2.0;

let SIDE_DURATION = 0.7;
let FRONT_DURATION = 1.5;
let BACK_DURATION = 3;

let morseTranslator = MorseCodeTranslator();

class HipChatRoomViewController: UIViewController {
    let socket = SocketIOClient(socketURL: "http://hipsdontlie.herokuapp.com")
    let manager = CMMotionManager();
    var resetAck: AckEmitter?
    var textView: UITextView?
    var locked:Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.addHandlers()
        self.socket.connect()
        
        manager.deviceMotionUpdateInterval = 0.1
        manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler:{ deviceManager, error in

        })

        if manager.gyroAvailable {
            println("gyro is available")
        }
        manager.gyroUpdateInterval = 0.1
        manager.startGyroUpdates()

        manager.startGyroUpdatesToQueue(NSOperationQueue.mainQueue()) { (data, error) in
            var gyroData: CMGyroData = data!;
            if gyroData.rotationRate.y < -SIDE_THRESHOLD {
                self.handleShakeRight(SIDE_DURATION);
            } else if gyroData.rotationRate.y > SIDE_THRESHOLD {
                self.handleShakeLeft(SIDE_DURATION);
            } else if gyroData.rotationRate.x < -BACK_THRESHOLD {
                self.handleBackwardThrust(BACK_THRESHOLD);
            } else if gyroData.rotationRate.x > FRONT_THRESHOLD {
                self.handleForwardThrust(FRONT_DURATION);
            }
        }
        
        self.view.backgroundColor = UIColor.whiteColor();
        
        // TODO: not needing this because we chat with our hips!!!
        // self.textView = UITextView(frame: CGRect(x: 0, y: self.view.frame.size.height-60, width: self.view.frame.size.width, height: 60));
        // self.textView?.backgroundColor = UIColor.lightGrayColor();
        // self.view.addSubview(self.textView!);
    }
    
    override func viewDidDisappear(animated: Bool) {
        manager.stopGyroUpdates();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addHandlers() {
        
        socket.on("typing") {data, ack in
            println("...")
        }

        socket.on("new message") {data, ack in
            if let theNewMessage = data?[0]["message"] as? NSString {
                println(theNewMessage);
            }
            
            if let theUserName = data?[0]["username"] as? NSString {
                println(theUserName);
            }
            
            // TODO: put it on the view
        }
        
        socket.on("connect") {data, ack in
            println("connected");
        }
        
        self.socket.onAny {println("Got event: \($0.event), with items: \($0.items)")}
    }
    
    // gyro:
    
    func handleShakeLeft(duration: NSTimeInterval) {
        println("left: ");
        morseTranslator.collect(Character("."));
        startLock(duration);
    }
    
    func handleShakeRight(duration: NSTimeInterval) {
        println("right: ");
        morseTranslator.collect(Character("-"));
        startLock(duration);
    }
    
    func handleForwardThrust(duration: NSTimeInterval) {
        println("forward: ");
        var letter: String? = morseTranslator.getTranslation(true);
        if letter != nil {
            socket.emit("new message", letter!);
        }
        morseTranslator.clearMorseCollection();
        startLock(duration);
    }
    
    func handleBackwardThrust(duration: NSTimeInterval) {
        println("backward: ");
        var letter: String? = morseTranslator.getTranslation(false);
        println("Message Composed");
        println(letter);
        startLock(duration);
    }
    
    func startLock(duration: NSTimeInterval) {
        locked = true;
        NSTimer.scheduledTimerWithTimeInterval(duration, target:self, selector:"unlock", userInfo:nil, repeats:false);
    }
    
    func unlock() {
        locked = false;
    }
}


