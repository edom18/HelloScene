
import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        scene.background.contents = [
            UIImage(named: "1-right"),
            UIImage(named: "2-left"),
            UIImage(named: "3-top"),
            UIImage(named: "4-bottom"),
            UIImage(named: "5-front"),
            UIImage(named: "6-back"),
        ]
        
        let view = self.view as SCNView
        view.allowsCameraControl = true
        
        view.scene = scene
        view.backgroundColor = UIColor.blackColor()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)

        scene.rootNode.addChildNode(cameraNode)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: -10, y: 10, z: 10)

        scene.rootNode.addChildNode(lightNode)
        
        let floorNode = SCNNode()
        let floor = SCNFloor()
        let floorMaterial = SCNMaterial()
        let floorPhysicsShape = SCNPhysicsShape(geometry: floor, options: nil)
        let floorPhysicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.Static, shape: floorPhysicsShape)
        floorMaterial.diffuse.contents = UIColor.grayColor()
        floorMaterial.reflective.contents = [
            UIImage(named: "1-right"),
            UIImage(named: "2-left"),
            UIImage(named: "3-top"),
            UIImage(named: "4-bottom"),
            UIImage(named: "5-front"),
            UIImage(named: "6-back"),
        ]

        floor.firstMaterial = floorMaterial
        floorNode.geometry = floor
        floorNode.physicsBody = floorPhysicsBody
        floorNode.position = SCNVector3(x: 0, y: -1.5, z: 0)
        
        scene.rootNode.addChildNode(floorNode)
        
        scene.physicsWorld.gravity = SCNVector3(x: 0, y: -98.0, z: 0)
        
        
        let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(tap)
    }
    
    func createBall() {
        let ballNode = SCNNode()
        let ballShape = SCNSphere(radius: 0.5)
        let ballMaterial = SCNMaterial()
        let ballPhysicsShape = SCNPhysicsShape(geometry: ballShape, options: nil)
        let ballPhysics = SCNPhysicsBody(type: SCNPhysicsBodyType.Dynamic, shape: ballPhysicsShape)
        ballMaterial.diffuse.contents = UIColor.grayColor()
        ballMaterial.specular.contents = UIColor.whiteColor()
        ballMaterial.reflective.contents = [
            UIImage(named: "1-right"),
            UIImage(named: "2-left"),
            UIImage(named: "3-top"),
            UIImage(named: "4-bottom"),
            UIImage(named: "5-front"),
            UIImage(named: "6-back"),
        ]
        ballShape.firstMaterial = ballMaterial
        ballNode.geometry = ballShape
        ballNode.physicsBody = ballPhysics
        
        let base: UInt32 = 10
        let x = (Float(arc4random_uniform(base)) * 2) - Float(base)
        let z = (Float(arc4random_uniform(base)) * 2) - Float(base)
        ballNode.position = SCNVector3(x: x, y: 5, z: z)
        
        (self.view as SCNView).scene.rootNode.addChildNode(ballNode)
    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        self.createBall()
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
