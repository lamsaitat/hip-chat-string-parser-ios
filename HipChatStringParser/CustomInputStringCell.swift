//
//  CustomInputStringCell.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 2/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import UIKit

typealias CustomInputStringCellParseActionBlock = (String?)->()

class CustomInputStringCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "CustomInputStringCell"
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var parseButton: UIButton!
    
    var parseActionBlock: CustomInputStringCellParseActionBlock?
    
    @IBAction func parseButtonTouchUpInside(sender: AnyObject) {
        inputTextField.resignFirstResponder()
        if parseActionBlock != nil {
            parseActionBlock!(inputTextField.text)
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
