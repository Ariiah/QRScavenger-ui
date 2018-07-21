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
    //
    //    @IBOutlet weak var placeholder: UILabel!
    //
    //    // GET JSON data
    //    func getData(url: String) {
    //
    //        Alamofire.request(API).responseJSON { response in
    //            if response.result.isSuccess {
    //
    //                let data : JSON = JSON(response.result.value!)
    //                print(data)
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
    //        print(text)
    //        //        print("show: \(type(of:text))")
    //    }
    //
    //    // Show text
    //    func displayText() {
    //        //        let data = text
    //        let textGeo = SCNText(string: "placeholder text", extrusionDepth: 1.0)
    //
    //        textGeo.firstMaterial?.diffuse.contents = UIColor.black
    //        textGeo.font = UIFont(name: "Arial", size: 4)
    //
    //        let textNode = SCNNode(geometry: textGeo)
    //        textNode.position = SCNVector3(-0.05,0.15,-0.29)
    //        textNode.scale = SCNVector3(0.002,0.002,0.002)
    //
    //        self.sceneView.scene.rootNode.addChildNode(textNode)
    //
    //        //        let action = SCNAction.fadeOpacity(by: -1, duration: 5.0)
    //        //        textNode.runAction(action)
    //    }
    
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
                
                //MARK: - iOS 11 & lower
                /*************************************************/
                
            } else {
                //         Fallback on earlier versions
                _ = ARWorldTrackingConfiguration()
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        
    }
    
    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.8)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            
            
            let noteScene = SCNScene(named: "art.scnassets/Note pad final.scn")!
            let noteNode = noteScene.rootNode.childNodes.first!
            noteNode.position = SCNVector3Zero
            noteNode.position.z = 0.15
            
            planeNode.addChildNode(noteNode)
            
            
            node.addChildNode(planeNode)
            
        }
        
        return node
    }
}
