//
//  ViewController+ObjectAdd.swift
//  carz
//
//  Created by Tobi Oluwo on 12/9/18.
//  Copyright © 2018 Tobi Oluwo. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

extension ViewController {
    
    fileprivate func getModel(named name: String) -> SCNNode? {
        let scene = SCNScene(named: "art.scnassets/car.scn")
        
//        name of 3d model node in car-model.scn
        guard let model = scene?.rootNode.childNode(withName: "Brake_Calliper_Brake", recursively: false)
            else {return nil}
        model.name = name
        
        var scale: CGFloat
        
        switch name {
        case "car":             scale = 0.00025
        default:                scale = 1
        }
        
        model.scale = SCNVector3(scale, scale, scale)
        return model
    }
    
    @IBAction func addObjectButtonTapped(_ sender: Any) {
        print("Add button tapped")
        
        guard focusSquare != nil else {return}
        
//      show car model when button is tapped
        let modelName = "car"
        guard let model = getModel(named: modelName) else {
            print("Unable to load \(modelName) from file")
            return
        }
        
        let hitTest = sceneView.hitTest(screenCenter, types: .existingPlaneUsingExtent)
        guard let worldTransformColumn3 = hitTest.first?.worldTransform.columns.3 else {return}
        model.position = SCNVector3(worldTransformColumn3.x, worldTransformColumn3.y, worldTransformColumn3.z)
        
        sceneView.scene.rootNode.addChildNode(model)
        print("\(modelName) added successfully")
        
        modelsInTheScene.append(model)
        print("Currently have \(modelsInTheScene.count) model(s) in the scene")
    }
}

