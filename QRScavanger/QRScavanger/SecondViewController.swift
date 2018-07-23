//
//  SecondViewController.swift
//  QRScavanger
//
//  Created by Aria on 7/16/18.
//  Copyright © 2018 Kelly Lockwood. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import BEMCheckBox


class SecondViewController: UIViewController {
    
    
    // Constants
    let API = "https://qr-scavenger.herokuapp.com/"
    
    // Outlets
    @IBOutlet weak var one: BEMCheckBox!
    
    @IBOutlet weak var compTextView: UITextView!
    
    // GET JSON data
    func getData(url: String) {
        
        Alamofire.request(API).responseJSON { response in
            if response.result.isSuccess {
                
                let data : JSON = JSON(response.result.value!)
                
                self.showData(json: data)
                
            }
        }
    }
    
    
    // Show JSON data
    func showData (json: JSON) {
        
        var text = ""
        for (_,subJson):(String, JSON) in json {
            if text.isEmpty {
                text = subJson["name"].string!
            } else {
                text += "\n\n\(numberCheckBoxes = [one])\t\(subJson["name"])"
//                print(type(of:numberCheckBoxes))

            }
        }
        compTextView.text = text
        
        let myString = text
        //        let style = NSMutableParagraphStyle()
        //        style.lineSpacing = 0
        //        let paragraph = [NSAttributedStringKey.paragraphStyle : style]
        let myAttribute = [ NSAttributedStringKey.font: UIFont(name: "Arial", size: 22.0)! ]
        
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        
        // set attributed text on a UILabel
        compTextView.attributedText = myAttrString
    }
    
    var numberCheckBoxes: [BEMCheckBox]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(url: API)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

