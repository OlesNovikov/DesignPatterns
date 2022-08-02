import Foundation

class RandomIntWithID {
    var value: Int = {
        print("value initialized")
        return Int.random(in: Int.min...Int.max)
    }()
    
    lazy var uid: String = {
        print("uid initialized")
        return UUID().uuidString
    }()
}

let n = RandomIntWithID()
print(n.uid)
