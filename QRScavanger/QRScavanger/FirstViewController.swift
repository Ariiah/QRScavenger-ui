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
    // let API = "https://qr-scavenger.herokuapp.com/"
    
    // AR outlet
    @IBOutlet weak var sceneView: ARSCNView!
    
    // GET JSON data
    //    func getData(url: String) {
    //        Alamofire.request(API).responseJSON { response in
    //            if response.result.isSuccess {
    //
    //                let data : JSON = JSON(response.result.value!)
    //                print("GET \(data)")
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
    //        print("Show \(text)")
    //        //        print("show: \(type(of:text))")
    //    }
    
    // Hardcoded Data
//    
//    lazy var lumoNode: SCNNode = {
//        let textGeo = SCNText(string: "This place helps with flight delays", extrusionDepth: 1.0)
//        textGeo.firstMaterial?.diffuse.contents = UIColor(red: 0.0, green: 5.0, blue: 0.0, alpha: 0.7)
//        textGeo.font = UIFont(name: "Arial", size: 8)
//        let textNode = SCNNode(geometry: textGeo)
//        textNode.scale = SCNVector3(0.002,0.002,0.002)
//        textNode.position = SCNVector3(-0.03,0.0, 0.06)
//        
////        planeNode.addChildNode(textNode)
//        textNode.eulerAngles.x = -.pi / 2
//        return textNode
//    }()
//    
//    lazy var bookNode: SCNNode = {
//        guard let scene = SCNScene(named: "book.scn"),
//            let node = scene.rootNode.childNode(withName: "book", recursively: false) else { return SCNNode() }
//        let scaleFactor  = 0.1
//        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
//        return node
//    }()
//    
//    lazy var mountainNode: SCNNode = {
//        guard let scene = SCNScene(named: "mountain.scn"),
//            let node = scene.rootNode.childNode(withName: "mountain", recursively: false) else { return SCNNode() }
//        let scaleFactor  = 0.25
//        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
//        node.eulerAngles.x += -.pi / 2
//        return node
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/GameScene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Call JSON
        // getData(url: API)
        
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

            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.0)
            //                plane.firstMaterial?.diffuse.contents = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)

            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2


            node.addChildNode(planeNode)

            // Render notepad (child node)
            //                let noteScene = SCNScene(named: "art.scnassets/Note pad final.scn")!
            //                let noteNode = noteScene.rootNode.childNodes.first!
            //                noteNode.position = SCNVector3Zero
            //                noteNode.position.z = 0.05
            //
            //                planeNode.addChildNode(noteNode)

            // Render text (child node)
            let textGeo = SCNText(string: "all the hints", extrusionDepth: 1.0)
            textGeo.firstMaterial?.diffuse.contents = UIColor(red: 0.0, green: 5.0, blue: 0.0, alpha: 0.7)
            textGeo.font = UIFont(name: "Arial", size: 8)
            let textNode = SCNNode(geometry: textGeo)
            textNode.scale = SCNVector3(0.002,0.002,0.002)
            textNode.position = SCNVector3(-0.03,0.0, 0.06)

            planeNode.addChildNode(textNode)

        }

        return node
    }
    
    
//    func getPlaneNode(withReferenceImage image: ARReferenceImage) -> SCNNode {
//        let plane = SCNPlane(width: image.physicalSize.width,
//                             height: image.physicalSize.height)
//        let node = SCNNode(geometry: plane)
//        return node
//    }
//
//    func getNode(withImageName name: String) -> SCNNode {
//        var node = SCNNode()
//        switch name {
//        case "Book":
//            node = lumoNode
////        case "Snow Mountain":
////            node = mountainNode
////        case "Trees In the Dark":
////            node = treeNode
//        default:
//            break
//        }
//        return node
//    }
    
}
