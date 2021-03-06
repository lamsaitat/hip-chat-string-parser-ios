//
//  InputStringListViewController.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 2/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import UIKit

enum InputStringListSection: Int {
    case PreDefined = 0
    case Custom = 1
}

let InputStringListToMessageSegue = "InputStringListToMessageSegue"

class InputStringListViewController: UITableViewController {
    
    static let identifier = "InputStringListViewController"
    static let preDefinedInputStringCellIdentifier = "InputStringCell"
    
    lazy var parser: HCParser = {
        let _parser = HCParserFactory.parser()
        return _parser
    }()
    
    var inputStrings: [String] = [
        "@chris you around?",
        "Good morning! (megusta) (coffee)",
        "Olympics are starting soon;http://www.nbcolympics.com",
        "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
    ]
    
    var selectedInputString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For the dynamic row height to work properly, set an arbitrary value to
        // the estimated row height, it's estimated only, not the final, 
        // don't worry.
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case InputStringListSection.PreDefined.rawValue:
            return inputStrings.count
        case InputStringListSection.Custom.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case InputStringListSection.PreDefined.rawValue:
            return "Atlassian test cases"
        case InputStringListSection.Custom.rawValue:
            return "Enter your own"
        default:
            return nil
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case InputStringListSection.PreDefined.rawValue:
            return self.tableView(tableView, preDefinedInputStringCellForRowAtIndexPath: indexPath)
        case InputStringListSection.Custom.rawValue:
            return self.tableView(tableView, customInputStringCellForRowAtIndexPath: indexPath)
        default:
            return self.tableView(tableView, fallbackCellForRowAtIndexPath: indexPath)
        }
    }
    
    private func tableView(tableView: UITableView, preDefinedInputStringCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let inputString = inputStrings[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(self.dynamicType.preDefinedInputStringCellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = inputString
        
        return cell
    }
    
    private func tableView(tableView: UITableView, customInputStringCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(CustomInputStringCell.identifier, forIndexPath: indexPath) as? CustomInputStringCell {
        
            cell.parseActionBlock = { (inputString: String?) in
                if inputString != nil && inputString!.isEmpty == false {
                    self.displayMessageViewWithInputString(inputString!)
                } else {
                    let alert = UIAlertController(
                        title: "Sorry",
                        message: "You have not entered anything to parse.",
                        preferredStyle: .Alert
                    )
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        
            return cell
        } else {
            return self.tableView(tableView, fallbackCellForRowAtIndexPath: indexPath)
        }
    }
    
    private func tableView(tableView: UITableView, fallbackCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // This is the worst case scenario, but show a meaningless cell is better than allow the app to crash...
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let customInputCell = cell as? CustomInputStringCell where indexPath.section == InputStringListSection.Custom.rawValue {
            customInputCell.inputTextField.resignFirstResponder()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == InputStringListSection.PreDefined.rawValue {
            let inputString = inputStrings[indexPath.row]
            
            displayMessageViewWithInputString(inputString)
        }
    }
    
    func displayMessageViewWithInputString(inputString: String) {
        selectedInputString = inputString
        performSegueWithIdentifier(InputStringListToMessageSegue, sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? MessageViewController where segue.identifier == InputStringListToMessageSegue && selectedInputString != nil {
            let dictionary = parser.dictionaryFromString!(selectedInputString!)
            let message = HCMessage(dictionary: dictionary)
            message.chatMessage = selectedInputString
            vc.message = message
        }
    }
}
