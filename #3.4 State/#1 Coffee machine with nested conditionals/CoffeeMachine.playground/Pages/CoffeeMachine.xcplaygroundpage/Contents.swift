import Foundation

class CoffeeMachine {
    private var isWaterTankFilled: Bool
    private var isCapsuleBinEmpty: Bool
    private var isCapsuleInserted: Bool

    required init(waterFilled: Bool, binEmpty: Bool, capsuleInserted: Bool) {
        isWaterTankFilled = waterFilled
        isCapsuleBinEmpty = binEmpty
        isCapsuleInserted = capsuleInserted
    }
    
    private func isReadyToBrew() -> Bool {
        var result = false
        
        if isWaterTankFilled {
            if isCapsuleBinEmpty {
                if isCapsuleInserted {
                    result = true
                    print("Coffee brewed")
                }
                else {
                    print("Insert capsule!")
                }
            }
            else {
                print("Capsule bin full!")
            }
        } else {
            print("Fill water tank!")
        }
        
        return result
    }
    
    func brew() {
        guard isReadyToBrew() else {
            print("Can't make coffee")
            return
        }
        print("Coffee ready!")
    }
}

let coffeeMachine = CoffeeMachine(waterFilled: true, binEmpty: true, capsuleInserted: false)
coffeeMachine.brew()
