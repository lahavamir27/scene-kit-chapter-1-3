//
//  ViewController.swift
//  scene kit
//
//  Created by Amir lahav on 24.4.2018.
//  Copyright © 2018 Amir lahav. All rights reserved.
//

import UIKit
import SceneKit
class ViewController: UIViewController {

    let useOmniLight                = true
    var useSpotlight                = false
    let useAmbientLight             = true   /// lights up the full scene a little bit
    let useTwoBoxes                 = true   /// another box with specular highlights
    let useMultipleMaterials        = true  /// different colors on each side
    
    
    @IBOutlet weak var sceneView: SCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        useSpotlight = !useOmniLight
        
        let scene = SCNScene()
        self.sceneView.scene = scene
        sceneView.allowsCameraControl = true
        // create new box
        let boxSize:CGFloat = 10
        let box = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        let boxNode = SCNNode()
        boxNode.geometry = box
        
        // create camera
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0,10,20)
        cameraNode.rotation = SCNVector4Make(1,0,0,  -atan2f(10.0, 20.0))
        
        
        // create light blue light
        
        let lightBlueColor = UIColor(displayP3Red: 4/255, green: 120/255, blue: 1, alpha: 1)
        
        box.firstMaterial?.diffuse.contents = lightBlueColor
        box.firstMaterial?.locksAmbientWithDiffuse = true
        
        let lightColor = UIColor.white

        
        if useOmniLight {
            let omniLight = SCNLight()
            omniLight.type = .omni
            omniLight.color = lightColor
            
            omniLight.attenuationStartDistance = 15
            omniLight.attenuationEndDistance = 20
            
            let omniLightNode = SCNNode()
            omniLightNode.light = omniLight
            cameraNode.addChildNode(omniLightNode)
        }
        
        if useSpotlight {
            let spotLight = SCNLight()
            spotLight.type = .spot
            spotLight.color = lightColor
            spotLight.spotInnerAngle = 25
            spotLight.spotOuterAngle = 30
            
            let spotLightNode = SCNNode()
            spotLightNode.light = spotLight
            cameraNode.addChildNode(spotLightNode)
        }
        
        
        if useAmbientLight {
            let ambientLight = SCNLight()
            ambientLight.type = .ambient
            ambientLight.color = UIColor(white: 0.75, alpha: 1)
            
            let ambientLightNode = SCNNode()
            ambientLightNode.light = ambientLight
            sceneView.scene?.rootNode.addChildNode(ambientLightNode)
            
        }
        
        if useTwoBoxes{
            cameraNode.position = SCNVector3(0,0,20)
            let noRotation = SCNVector4Make(1, 0, 0, 0)
            
            cameraNode.rotation = noRotation
            boxNode.rotation = noRotation
            
            let anotherBox = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
            anotherBox.firstMaterial?.diffuse.contents = lightBlueColor
            anotherBox.firstMaterial?.locksAmbientWithDiffuse = true
            anotherBox.firstMaterial?.specular.contents = UIColor.white
            
            let anotherBoxNode = SCNNode(geometry: anotherBox)
            sceneView.scene?.rootNode.addChildNode(anotherBoxNode)
            
            let boxMargin:CGFloat = 1.0
            let boxPostionX = (boxSize + boxMargin)/2
            boxNode.position = SCNVector3(boxPostionX, 0 ,0)
            anotherBoxNode.position = SCNVector3(-boxPostionX, 0, 0)

        }
        let light = SCNLight()
        light.type = .directional
        light.color = UIColor.white
        let lightNode = SCNNode()
        lightNode.light = light
//        cameraNode.addChildNode(lightNode)
        
        // add nodes to scene
        sceneView.scene?.rootNode.addChildNode(cameraNode)
        sceneView.scene?.rootNode.addChildNode(boxNode)

        
        // add sceneView to main view
        self.view.addSubview(sceneView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

