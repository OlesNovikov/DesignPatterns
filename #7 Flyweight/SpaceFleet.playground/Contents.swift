import UIKit

class SharedSpaceShipData {
    private let mesh: [Float]
    private let texture: UIImage?
    
    init(mesh: [Float], imageNamed name: String) {
        self.mesh = mesh
        self.texture = UIImage(named: name)
    }
}

class SpaceShip {
    private var position: (Float, Float, Float)
    private var intrisicState: SharedSpaceShipData

    init(sharedData: SharedSpaceShipData, position: (Float, Float, Float) = (0, 0, 0)) {
        self.position = position
        self.intrisicState = sharedData
    }
}


let fleetSize = 1000
var ships = [SpaceShip]()
var vertices = [Float](repeating: 0, count: 1000)

let sharedState = SharedSpaceShipData(mesh: vertices, imageNamed: "SpaceShip")

for _ in 0..<fleetSize {
    let ship = SpaceShip(sharedData: sharedState,
                         position: (Float.random(in: 1...100),
                                    Float.random(in: 1...100),
                                    Float.random(in: 1...100)))
    ships.append(ship)
}

