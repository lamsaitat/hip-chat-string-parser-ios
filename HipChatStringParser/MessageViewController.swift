//
//  MessageViewController.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 2/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    static let identifier = "MessageViewController"
    
    @IBOutlet weak var contentTextView: UITextView!
    var message: HCMessage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func reloadButtonTouchUpInside(sender: AnyObject?) {
        
    }

}
