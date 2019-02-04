//
//  ViewController.swift
//  TestProject
//
//  Created by Анастасия Соколан on 25.01.19.
//  Copyright © 2019 Анастасия Соколан. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /*@IBAction func act(_ sender: Any) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "Enter a message";
        messageVC.recipients = ["Enter tel-nr"]
        messageVC.messageComposeDelegate = self
        
        self.present(messageVC, animated: true, completion: nil)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checkNet()
    }
    
    func checkNet() {
        var targets: [YandexServerAPI]  = [
            YandexServerAPI.getLangs(ui: "en"),
            YandexServerAPI.translate(text: "cat", lang: "ru")
        ]
        NetworkManager.request(target: targets[0])
        //NetworkManager.request(target: targets[1])

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            dismiss(animated: true, completion: nil)
        }
    }*/
}

