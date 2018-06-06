//
//  ViewController.swift
//  ARAds
//
//  Created by Mohammad Azam on 3/26/18.
//  Copyright © 2018 Mohammad Azam. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor is ARImageAnchor {
            
            let phoneScene = SCNScene(named: "Phone_01.scn")!
            let phoneNode = phoneScene.rootNode.childNode(withName: "parentNode", recursively: true)!
            
            // rotate the phone node
            let rotationAction = SCNAction.rotateBy(x: 0, y: 0.5, z: 0, duration: 1)
            let inifiniteAction = SCNAction.repeatForever(rotationAction)
            phoneNode.runAction(inifiniteAction)
            
            phoneNode.position = SCNVector3(anchor.transform.columns.3.x,anchor.transform.columns.3.y + 0.1,anchor.transform.columns.3.z)
            
            node.addChildNode(phoneNode)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        configuration.maximumNumberOfTrackedImages
        
        configuration.trackingImages = referenceImages
      
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}
