//
//  HCMessageViewModel.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 4/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import UIKit

class HCMessageViewModel: NSObject {
    var message: HCMessage
    
    required init(message: HCMessage) {
        self.message = message
    }
    
    func displayString() -> String? {
        var displayString = ""
        
        if message.chatMessage.isEmpty == false {
            displayString += "Input String:\n\(message.chatMessage)\n\n"
        }
        
        let jsonString = message.jsonString
        
        if jsonString.isEmpty == false {
            displayString += "JSON output:\n\(jsonString)\n"
        }
        
        if displayString.isEmpty {
            return nil
        }
        return displayString
    }
}
