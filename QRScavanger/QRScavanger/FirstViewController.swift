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
//import Alamofire
//import SwiftyJSON

class FirstViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    // Show text
    func displayText() {
        
        let textGeo = SCNText(string: "Hello", extrusionDepth: 1.0)
        
        textGeo.firstMaterial?.diffuse.contents = UIColor.black
        textGeo.font = UIFont(name: "Arial", size: 2)
        
        let textNode = SCNNode(geometry: textGeo)
        textNode.position = SCNVector3(-0.05,0.15,-0.29)
        textNode.scale = SCNVector3(0.002,0.002,0.002)
        
        self.sceneView.scene.rootNode.addChildNode(textNode)
        
//        let action = SCNAction.fadeOpacity(by: -1, duration: 5.0)
//        textNode.runAction(action)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/Note pad final.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Render text on screen
        displayText()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
