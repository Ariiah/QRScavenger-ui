//
//  ViewController.swift
//  AR Test
//
//  Created by Kelly Lockwood on 7/18/18.
//  Copyright © 2018 Kelly Lockwood. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController, ARSCNViewDelegate {
    
    // Constants
//    let API = "https://qr-scavenger.herokuapp.com/"
    
    // AR outlet
    @IBOutlet weak var sceneView: ARSCNView!
    
//    // GET JSON data
//    func getData(url: String) {
//
//        Alamofire.request(API).responseJSON { response in
//            if response.result.isSuccess {
//
//                let data : JSON = JSON(response.result.value!)
////                print(data)
//                //                print("get: \(type(of:data))")
//                self.showData(json: data)
//            }
//        }
//    }
//
//    // Show JSON data
//    var text = ""
//    func showData(json: JSON) {
//        for (_,subJson):(String, JSON) in json {
//            if text.isEmpty {
//                text = subJson["hint"].string!
//            } else {
//                text += "\n\n\(subJson["hint"])"
//            }
//        }
////                    print(text)
//        //        print("show: \(type(of:text))")
//    }
    
    // GET TEXT data

    
    // Show text
//            func displayText() {
//                //        let data = text
//                let textGeo = SCNText(string: "placeholder text", extrusionDepth: 1.0)
//
//                textGeo.firstMaterial?.diffuse.contents = UIColor.black
//                textGeo.font = UIFont(name: "Arial", size: 4)
//
//                let textNode = SCNNode(geometry: textGeo)
//                textNode.position = SCNVector3(-0.05,0.15,0.29)
//                textNode.scale = SCNVector3(0.002,0.002,0.002)
//
//                self.sceneView.scene.rootNode.addChildNode(textNode)
//
//                //        let action = SCNAction.fadeOpacity(by: -1, duration: 5.0)
//                //        textNode.runAction(action)
//            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/GameScene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Render text on screen
//        displayText()
        
        
        // Debug
//        sceneView.showsStatistics = true
//        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
//        sceneView.debugOptions = ARSCNDebugOptions.showWorldOrigin

        
//        let url = URL(string: "https://qr-scavenger.herokuapp.com/")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "GET"
        
//        _ = URLSession(configuration: request, delegate:nil, delegateQueue: true)

//
//       var data = NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
////            return NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
//            return "HI"
//        }
        
        
//        let result = data.split(separator: "\n")
//        print(result)

//        var sep = data.components(separatedBy: "|")
        
        // Call JSON
//        getData(url: API)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: - iOS 12
        /*****************************************************/
        
        
        // Create a session configuration
        if #available(iOS 12.0, *) {
            if ARImageTrackingConfiguration.isSupported {
                let configuration = ARImageTrackingConfiguration()

                guard let trackedImages =
                    ARReferenceImage.referenceImages(inGroupNamed: "Photos", bundle: Bundle.main) else {
                        print("No image")
                        return
                }

                configuration.trackingImages = trackedImages
                configuration.maximumNumberOfTrackedImages = 1

                // Run the view's session
                sceneView.session.run(configuration)

                //MARK: - iOS 11.4
                /***********************************************/

            } /*else {
                _ = ARWorldTrackingConfiguration()
//                // Load reference images to look for from "AR Resources" folder
//                guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "Photos", bundle: nil) else {
//                    fatalError("Missing expected asset catalog resources.")
//                }
//
//                // Create a session configuration
//                let configuration = ARWorldTrackingConfiguration()
//
//                // Add previously loaded images to ARScene configuration as detectionImages
//                configuration.detectionImages = referenceImages
//
//                // Run the view's session
//                sceneView.session.run(configuration)
            }*/
        
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        
    }
    
    // Render all assets
        func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    
            let node = SCNNode()
    
            // Render plane (parent node)
            if let imageAnchor = anchor as? ARImageAnchor {
                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
    
                plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.8)
//                plane.firstMaterial?.diffuse.contents = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -.pi / 2
                
    
                node.addChildNode(planeNode)
                
                // Render notepad (child node)
                let noteScene = SCNScene(named: "art.scnassets/Note pad final.scn")!
                let noteNode = noteScene.rootNode.childNodes.first!
                noteNode.position = SCNVector3Zero
                noteNode.position.z = 0.05

                planeNode.addChildNode(noteNode)

                // Render text (child node)
                let textGeo = SCNText(string: "This place is known for cutting down \n time on your flight delays!", extrusionDepth: 0.5)
                textGeo.firstMaterial?.diffuse.contents = UIColor.black
                textGeo.font = UIFont(name: "Arial", size: 4)

                let textNode = SCNNode(geometry: textGeo)
                textNode.scale = SCNVector3(0.002,0.002,0.002)
                textNode.position = SCNVector3(-0.06,0.0395, 0.06)

                planeNode.addChildNode(textNode)

            }
    
            return node
    }
}
