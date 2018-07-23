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
//        //            print(text)
//        //        print("show: \(type(of:text))")
//    }
    
    // Show text
    //        func displayText() {
    //            //        let data = text
    //            let textGeo = SCNText(string: "placeholder text", extrusionDepth: 1.0)
    //
    //            textGeo.firstMaterial?.diffuse.contents = UIColor.black
    //            textGeo.font = UIFont(name: "Arial", size: 4)
    //
    //            let textNode = SCNNode(geometry: textGeo)
    //            textNode.position = SCNVector3(-0.05,0.15,0.29)
    //            textNode.scale = SCNVector3(0.002,0.002,0.002)
    //
    //            self.sceneView.scene.rootNode.addChildNode(textNode)
    //
    //            //        let action = SCNAction.fadeOpacity(by: -1, duration: 5.0)
    //            //        textNode.runAction(action)
    //        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/GameScene.scn")!
        
        // Set the scene to the view
//        sceneView.scene = scene
        
        // Render text on screen
        //                displayText()
        
        // Call JSON
//        getData(url: API)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: - iOS 12
        /*****************************************************/
        
        
        // Create a session configuration
//        if #available(iOS 12.0, *) {
//            if ARImageTrackingConfiguration.isSupported {
//                let configuration = ARImageTrackingConfiguration()
//
//                guard let trackedImages =
//                    ARReferenceImage.referenceImages(inGroupNamed: "Photos", bundle: Bundle.main) else {
//                        print("No image")
//                        return
//                }
//
//                configuration.trackingImages = trackedImages
//                configuration.maximumNumberOfTrackedImages = 1
//
//                // Run the view's session
//                sceneView.session.run(configuration)
//
//                //MARK: - iOS 11.4
//                /***********************************************/
//
//            } else {
                // Load reference images to look for from "AR Resources" folder
                guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "Photos", bundle: nil) else {
                    fatalError("Missing expected asset catalog resources.")
                }
                
                // Create a session configuration
                let configuration = ARWorldTrackingConfiguration()
                
                // Add previously loaded images to ARScene configuration as detectionImages
                configuration.detectionImages = referenceImages
                
                // Run the view's session
                sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
//            }
        
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        
    }
    
    
    //MARK: - Original code
    /********************************************/
    // Render all assets
    //    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    //
    //        let node = SCNNode()
    
    // Render notepad after reading image
    //        if let imageAnchor = anchor as? ARImageAnchor {
    //            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
    //
    //            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.8)
    //
    //            let planeNode = SCNNode(geometry: plane)
    //            planeNode.eulerAngles.x = -.pi / 2
    //
    //
    //            let noteScene = SCNScene(named: "art.scnassets/Note pad final.scn")!
    //            let noteNode = noteScene.rootNode.childNodes.first!
    //            noteNode.position = SCNVector3Zero
    //            noteNode.position.z = 0.05
    //
    //            node.addChildNode(planeNode)
    //
    //            planeNode.addChildNode(noteNode)
    
    // Render text
    //            let textGeo = SCNText(string: "placeholder text", extrusionDepth: 1.0)
    //
    //            textGeo.firstMaterial?.diffuse.contents = UIColor.black
    //            textGeo.font = UIFont(name: "Arial", size: 8)
    //
    //            let textNode = SCNNode(geometry: textGeo)
    //            textNode.scale = SCNVector3(0.002,0.002, 0.002)
    //            //            textNode.position = SCNVector3(0.03, 0.03, -0.03)
    //            textNode.pivot = SCNMatrix4Rotate(node.pivot, Float.pi, 0, 1, 0.03)
    //            //            textNode.SCNLookAtConstraint()
    //
    //            node.addChildNode(textNode)
    //
    //            textNode.addChildNode(textNode)
    //
    //        }
    //
    //        return node
    
    //MARK: - Test code
    /*****************************************/
    
    private var planeNode: SCNNode?
    private var imageNode: SCNNode?
    //    private var animationInfo: AnimationInfo?
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node : SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
        
        // 1. Load plane's scene.
        _ = SCNScene(named: "art.scnassets/Note pad final.scn")!
//        let planeNode = planeScene.rootNode.childNode(withName: "planeRootNode", recursively: true)!
        
        // 2. Calculate size based on planeNode's bounding box.
        let (min, max) = (planeNode?.boundingBox)!
        let size = SCNVector3Make(max.x - min.x, max.y - min.y, max.z - min.z)
        
        // 3. Calculate the ratio of difference between real image and object size.
        // Ignore Y axis because it will be pointed out of the image.
        let widthRatio = Float(imageAnchor.referenceImage.physicalSize.width)/size.x
        let heightRatio = Float(imageAnchor.referenceImage.physicalSize.height)/size.z
        // Pick smallest value to be sure that object fits into the image.
        let finalRatio = [widthRatio, heightRatio].min()!
        
        // 4. Set transform from imageAnchor data.
        planeNode?.transform = SCNMatrix4(imageAnchor.transform)
        
        // 5. Animate appearance by scaling model from 0 to previously calculated value.
        let appearanceAction = SCNAction.scale(to: CGFloat(finalRatio), duration: 0.4)
        appearanceAction.timingMode = .easeOut
        // Set initial scale to 0.
        planeNode?.scale = SCNVector3Make(0, 0, 0)
        // Add to root node.
        sceneView.scene.rootNode.addChildNode(planeNode!)
        // Run the appearance animation.
        planeNode?.runAction(appearanceAction)
        
//        planeNode = planeNode
        imageNode = node
        
    }
}
