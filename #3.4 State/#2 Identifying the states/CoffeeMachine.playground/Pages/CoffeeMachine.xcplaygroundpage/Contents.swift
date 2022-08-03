import Foundation

fileprivate protocol CoffeeMachineState {
    func isReadyToBrew() -> Bool
    func brew()
}

extension CoffeeMachineState {
    
    func isReadyToBrew() -> Bool {
        print("\(#function) not implemented for \(self) state")
        return false
    }
    
    func brew() {
        print("\(#function) not implemented for \(self) state")
    }
    
}

fileprivate struct StandbyState: CoffeeMachineState {
    
}

fileprivate struct FillWaterTankState: CoffeeMachineState {
    
}

fileprivate struct EmptyCapsuleBinState: CoffeeMachineState {
    
}

fileprivate struct InsertCapsuleState: CoffeeMachineState {
    
}

fileprivate struct BrewCoffeeState: CoffeeMachineState {
    
}

class CoffeeMachine {
    private var isWaterTankFilled: Bool
    private var isCapsuleBinEmpty: Bool
    private var isCapsuleInserted: Bool
    
    fileprivate var state: CoffeeMachineState = StandbyState()

    required init(waterFilled: Bool, binEmpty: Bool, capsuleInserted: Bool) {
        isWaterTankFilled = waterFilled
        isCapsuleBinEmpty = binEmpty
        isCapsuleInserted = capsuleInserted
    }
    
    fileprivate func isReadyToBrew() -> Bool {
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
