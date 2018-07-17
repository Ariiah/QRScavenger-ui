//
//  SecondViewController.swift
//  QRScavanger
//
//  Created by Aria on 7/16/18.
//  Copyright © 2018 Kelly Lockwood. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    func fetchResultsFromApi() {
        struct MyGitHub: Codable {
            
            let name: String?
            let hint: String?
//            let followers: Int?
//            let avatarUrl: URL?
//            let repos: Int?
//
            private enum CodingKeys: String, CodingKey {
                case name
                case hint
//                case followers
//                case repos = "public_repos"
//                case avatarUrl = "avatar_url"
                
            }
        }
        guard let gitUrl = URL(string: "https://qr-scavenger.herokuapp.com") else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(MyGitHub.self, from: data)
                print(gitData.name ?? "Empty Name")
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
    
    let url = "https://qr-scavenger.herokuapp.com"
    URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
    
    if let d = data {
    if let value = String(data: d, encoding: String.Encoding.ascii) {
    
    if let jsonData = value.data(using: String.Encoding.utf8) {
    do {
    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
    
    if let arr = json["rows"] as? [[String: Any]] {
    debugPrint(arr)
    }
    
    } catch {
    NSLog("ERROR \(error.localizedDescription)")
    }
    }
    }
    
    }
    }.resume()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchResultsFromApi()
        
//        var request = URLRequest(url: URL(string: "https://qr-scavenger.herokuapp.com")!)
//
//        request.httpMethod = "GET"
        
//        let url = URL(string: "https://qr-scavenger.herokuapp.com")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "GET"
//
//        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.mainQueue()) {(response, data, error) in
//            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
//        }
//

        // create the request
//        let url = URL(string: "https://qr-scavenger.herokuapp.com")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
////        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//
//        // fire off the request
//        // make sure your class conforms to NSURLConnectionDelegate
//        let urlConnection = NSURLConnectionDataDelegate(request: request, delegate: self)
        
        
//        let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)

//        let url = URL(string: "https://qr-scavenger.herokuapp.com")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "GET"
//
//        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
//            print(data)
//        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

