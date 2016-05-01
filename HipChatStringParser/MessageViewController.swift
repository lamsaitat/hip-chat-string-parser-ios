//
//  MessageViewController.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 2/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import UIKit
import MBProgressHUD

class MessageViewController: UIViewController {
    
    static let identifier = "MessageViewController"
    
    @IBOutlet weak var contentTextView: UITextView!
    
    lazy var parser: HCParser = {
        let _parser = HCParserFactory.urlFetchingParser()
        return _parser
    }()
    
    var message: HCMessage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTextView.text = displayString(message)
        
        fetchPageTitleIfRequired()
    }

    @IBAction func reloadButtonTouchUpInside(sender: AnyObject?) {
        fetchPageTitleIfRequired()
    }
    
    private func updateContentText() {
        contentTextView.text = displayString(message)
    }
    
    private func fetchPageTitleIfRequired() {
        if message?.links.count > 0 {
            let hud = MBProgressHUD.showHUDAddedTo(UIApplication.sharedApplication().windows.first, animated: true)
            hud.labelText = "Loading..."
            parser.fetchPageTitlesWithMessage!(
                message,
                completionBlock: { (returningMessage: HCMessage!, error: NSError?) in
                    
                    if error == nil {
                        self.message = returningMessage
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            self.updateContentText()
                        })
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        hud.hide(true)
                    })
                }
            )
        }
    }

    private func displayString(message: HCMessage?) -> String? {
        if message == nil {
            return nil
        }
        
        var displayString = ""
        
        if message!.chatMessage.isEmpty == false {
            displayString += "Input String:\n\(message!.chatMessage)\n\n"
        }
        
        let jsonString = message!.jsonString
        
        if jsonString.isEmpty == false {
            displayString += "JSON output:\n\(jsonString)\n"
        }
        
        if displayString.isEmpty {
            return nil
        }
        return displayString
    }
}
