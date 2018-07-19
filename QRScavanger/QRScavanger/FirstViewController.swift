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
        
//        let material = SCNMaterial()
        
//        material.diffuse.contents = UIImage(named: "art.scnassets/note_pad_large.scn")
        
        // gives it light and shadows to appear 3D
        
//        sceneView.autoenablesDefaultLighting = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/Note pad final.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
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
