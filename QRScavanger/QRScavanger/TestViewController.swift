//
//  TestViewController.swift
//  
//
//  Created by Aria on 7/22/18.
//
//
//import Foundation
//
//func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//    guard let imageAnchor = anchor as? ARImageAnchor else {
//        return
//    }
//
//    // 1. Load plane's scene.
//    let planeScene = SCNScene(named: "art.scnassets/plane.scn")!
//    let planeNode = planeScene.rootNode.childNode(withName: "planeRootNode", recursively: true)!
//
//    // 2. Calculate size based on planeNode's bounding box.
//    let (min, max) = planeNode.boundingBox
//    let size = SCNVector3Make(max.x - min.x, max.y - min.y, max.z - min.z)
//
//    // 3. Calculate the ratio of difference between real image and object size.
//    // Ignore Y axis because it will be pointed out of the image.
//    let widthRatio = Float(imageAnchor.referenceImage.physicalSize.width)/size.x
//    let heightRatio = Float(imageAnchor.referenceImage.physicalSize.height)/size.z
//    // Pick smallest value to be sure that object fits into the image.
//    let finalRatio = [widthRatio, heightRatio].min()!
//
//    // 4. Set transform from imageAnchor data.
//    planeNode.transform = SCNMatrix4(imageAnchor.transform)
//
//    // 5. Animate appearance by scaling model from 0 to previously calculated value.
//    let appearanceAction = SCNAction.scale(to: CGFloat(finalRatio), duration: 0.4)
//    appearanceAction.timingMode = .easeOut
//    // Set initial scale to 0.
//    planeNode.scale = SCNVector3Make(0, 0, 0)
//    // Add to root node.
//    sceneView.scene.rootNode.addChildNode(planeNode)
//    // Run the appearance animation.
//    planeNode.runAction(appearanceAction)
//
//    self.planeNode = planeNode
//    self.imageNode = node
//}
