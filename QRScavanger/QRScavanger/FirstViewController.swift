//
//  ViewController.swift
//  AR Test
//
//  Created by Aria on 7/18/18.
//  Copyright © 2018 Kelly Lockwood. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class FirstViewController: UIViewController, ARSCNViewDelegate {
    
//    @IBOutlet var sceneView: ARSCNView!
    
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        //        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        
        let sphere = SCNSphere(radius: 0.2)
        
        let material = SCNMaterial()
        
        //        material.diffuse.contents = UIImage(named: "art.scnassets/*img file*")
        
        sphere.materials = [material]
        
        let node = SCNNode()
        
        // z index - negative means farther away from you
        node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
        
        node.geometry = sphere
        
        sceneView.scene.rootNode.addChildNode(node)
        
        // gives it light and shadows to appear 3D
        
        sceneView.autoenablesDefaultLighting = true
        
        // Show statistics such as fps and timing information
        //        sceneView.showsStatistics = true
        
        //        // Create a new scene
        //        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        //
        //        // Set the scene to the view
        //        sceneView.scene = scene
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
