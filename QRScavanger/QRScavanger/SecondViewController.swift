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

class SecondViewController: UIViewController {
    
    // Constants
    let API = "https://qr-scavenger.herokuapp.com/"
    
    
    @IBOutlet weak var compTextView: UITextView!

    
    func getData(url: String) {
        
        Alamofire.request(API).responseJSON { response in
            if response.result.isSuccess {
                
                let data : JSON = JSON(response.result.value!)
                
                print(data)
                self.showData(json: data)
                
            }
        }
    }
    
    func showData (json: JSON) {
        
        var text = ""
        for (_,subJson):(String, JSON) in json {
            if text.isEmpty {
                text = subJson["name"].string!
            } else {
                text += "\n\(subJson["name"])"
            }
        }
        compTextView.text = text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(url: API)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

