

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }

    override func viewDidAppear(_ animated: Bool) {
        let mainearth = SCNNode(geometry: SCNSphere(radius: 0.75))

        mainearth.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun diffuse")
        mainearth.position = SCNVector3(-6,-2,-1)
        let Rotator = Rotation(time: 8)
        mainearth.runAction(Rotator)

        self.sceneView.scene.rootNode.addChildNode(mainearth)
        
        let earth1 = generatePlanetWithOrbit(root: nil, orbitRoot: SCNVector3(-3,-2,-1), rotation: 0, geometry: SCNSphere(radius: 0.75), diffuse: #imageLiteral(resourceName: "Mercury Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1,0,0))
        let earth2 = generatePlanetWithOrbit(root: nil, orbitRoot: SCNVector3(0,-2,-1), rotation: 0, geometry: SCNSphere(radius: 0.75), diffuse: #imageLiteral(resourceName: "Mars Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1,0,0))
        let earth3 = generatePlanetWithOrbit(root: nil, orbitRoot: SCNVector3(3,-2,-1), rotation: 0, geometry: SCNSphere(radius: 0.75), diffuse: #imageLiteral(resourceName: "Earth day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1,0,0))
        let earth4 = generatePlanetWithOrbit(root: nil, orbitRoot: SCNVector3(6,-2,-1), rotation: 0, geometry: SCNSphere(radius: 0.75), diffuse: #imageLiteral(resourceName: "Moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1,0,0))
        let earth5 = generatePlanetWithOrbit(root: nil, orbitRoot: SCNVector3(9,-2,-1), rotation: 0, geometry: SCNSphere(radius: 0.75), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: nil, normal: nil, position: SCNVector3(1,0,0))
       
    }
    

    func generatePlanetWithOrbit(root: SCNNode?, orbitRoot: SCNVector3, rotation: TimeInterval, geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {

        let parent = SCNNode()
        parent.position = orbitRoot
        self.sceneView.scene.rootNode.addChildNode(parent)
        
        let newPlanet = planet(geometry: geometry, diffuse: diffuse, specular: specular, emission: emission, normal: normal, position: position)
        
        let planetRotation = Rotation(time: 8)
        let rootRotation = Rotation(time: rotation)
        
        newPlanet.runAction(planetRotation)
        parent.runAction(rootRotation)
        parent.addChildNode(newPlanet)
        root?.addChildNode(parent)
        
        return parent
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    
    func Rotation(time: TimeInterval) -> SCNAction {
        let rotation = time != 0 ? 360.degreesToRadians : 0
        let rotator = SCNAction.rotateBy(x:0, y: CGFloat(rotation), z: 0, duration: time != 0 ? time : 1)
        let foreverRotator = SCNAction.repeatForever(rotator)
        return foreverRotator
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

