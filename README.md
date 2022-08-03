# DesignPatterns
This is training project taken from [Practical Design Patterns in Swift](https://www.linkedin.com/learning/practical-design-patterns-in-swift)

<h3>1. Creational Design Patterns</h3>

* [Singleton](#singleton) (ensures that there is only one instance of a type)
* [Prototype](#prototype) (concerned with the cloning of objects)
* [Factory Method](#factory) (creates objects without knowing its exact type)

<h3>2. Structural Design Patterns</h3>

* [Adapter](#adapter) (wraps an incompatible type and exposes an interface that's familiar to the caller)
* [Decorator](#decorator) (allows to add new responsibilities to objects dynamically)
* [Facade](#facade) (simplifies the usage of complex types)
* [Flyweight](#flyweight) (reduces memory usage by sharing common data between objects)
* [Proxy](#proxy) (manage and controll access to specific objects)

<h3>3. Behavioral Design Patterns</h3>

* [Chain of Responsibility](#chain)
* [Iterator](#iterator) (provides sequential access to the elements of an aggregate object)
* [Observer](#observer) (lets objects subscribe for notifications without being tightly coupled to the sender)
* [State](#state) (replaces complex conditional logic with an object-oriented state machine)



<h2 id="singleton">1.1 Singleton</h2>

Concurrency issue: one thread could write to property another read from this property => crash

<u>**Solution 1**</u>

Execute code in serial queue

```swift
public func set(value: Any, forKey key: String) {
    serialQueue.sync {
        self.settings[key] = value
    }
}
```

**<u>Solution 2</u>** (optimized for performance)

Execute code in concurrent queue with reader's right lock
WRITE **.async** with flags **.barrier**. Code won't be processed until all other operations complete

```swift
public func set(value: Any, forKey key: String) {
    concurrentQueue.async(flags: .barrier) {
        self.settings[key] = value
    }
}
```

READ **.sync**

```swift
public func string(forKey key: String) -> String? {
    var result: String?
    concurrentQueue.sync {
        result = self.settings[key] as? String
    }
    return result
}
```



<h2 id="prototype">1.2 Prototype</h2>

Problem: 1 object creates in 1ms, then 1000 in 1000ms. TOO LONG! Prototype patterns helps to decrease creation time.

**Value** types - has protorype behaviour outside a "box".<br>
**Reference** types - doesn't have.

<u>**Solution**</u>

```swift
class NameClass: NSCopying {
    // other code
    func copy(with zone: NSZone? = nil) -> Any {
        return NameClass(firstName: self.firstName, lastName: self.lastName)
    }
  
    // call this method to clone instance
    func clone() -> NameClass {
        return self.copy() as! NameClass
    }
}

// using
var steve = NameClass(firstName: "Steve", lastName: "Johnson")
var john = steve.clone()
```

Changing john instance doesn't affect on steve object



<h2 id="factory">1.3 The Factory Method</h2>

This pattern encapsulates objects creation in one method. This method returns objects which types implements protocol.

Problem: objects created directly depending on each type - this is not flexible for future changing (what if you would change type?)

**<u>Solution</u>**

```swift
struct SerializerFactory {
    
    static func makeSerializer(_ type: Serializers) -> Serializable? {
        let result: Serializable?
        switch type {
        case .json: result = JSONSerializer()
        case .plist: result = PropertyListSerializer()
        case .xml: result = XMLSerializer()
        }
        return result
    }
    
}
```

All this classes - JSONSerializer, PropertyListSerializer, XMLSerializer - implement Serializable protocol



<h2 id="adapter">2.1 Adapter</h2>

Adapter pattern becomes a link between 3rd party library and existing source code

Problem: third party library doesn't conform to existing protocol but has similar functionality which you need

**<u>Solution 1</u>**

Create class wrapper wich will implement existing protocol from source code

```swift
// adapter class which implements existing protocol
class AmazonPaymentsAdapter: PaymentGateway {
    // amazonPayments - object from 3rd party library
    var totalPayments: Double {
        let total = amazonPayments.payments
        print("Total payments received via Amazon Payments: \(total)")
        return total
    }
    
    func receivePayment(amount: Double) {
        amazonPayments.paid(value: amount, currency: "USD")
    }
    
}
```

**<u>Solution 2</u>**

Create an extension to type from 3rd party library

```swift
extension AmazonPayments: PaymentGateway {
    func receivePayment(amount: Double) {
        self.paid(value: amount, currency: "USD")
    }
    
    var totalPayments: Double {
        let total = self.payments
        print("Total payments received via Amazon Payments: \(total)")
        return total
    }
}
```




<h2 id="decorator">2.2 Decorator</h2>

Problem: you have a type and you want to expand it's functionality

**<u>Solution 1</u>**

Create class inherited from target class and wrap the value. Then to create 'decorate' more functions/properties etc.

```swift
	class UserDefaultsDecorator: UserDefaults {
    // wrapped value
    private var userDefaults = UserDefaults.standard
    
    convenience init(userDefaults: UserDefaults) {
        self.init()
        self.userDefaults = userDefaults
    }
    
    // new function
    func set(date: Date?, forKey key: String) {
        userDefaults.set(date, forKey: key)
    }
    // ...
```

**<u>Solution 2</u>**

Use extensions if you don't need to use stored properties / property observers

```swift
extension UserDefaults {
    
    func set(date: Date?, forKey key: String) {
        self.set(date, forKey: key)
    }
    //...
}
```



<h2 id="facade">2.3 Facade</h2>

Problem: you have a big library but want to use only 3 functions

<u>**Solution**</u>

Create class in which you wrap functions from library to reuse it later - in Beta testing for instance

![image-20220801180918983](https://tva1.sinaimg.cn/large/e6c9d24egy1h4ro635uixj20t60kwmxs.jpg)



<h2 id="flyweight">2.4 Flyweight</h2>

Problem: you have to creat 1000 shaceships. 1 spaceship == 300 KB of memory -> 1000 spaceships == 300 MB of memory.

**<u>Solution</u>**

Create reference type object with common data shared with other 1000 "spaceships" to use.

```swift
// every spaceship have mesh and texture
class SharedSpaceShipData {
    private let mesh: [Float]
    private let texture: UIImage?
    //...
}
// spaceship class with reference to common data in shared spaceship data object
class SpaceShip {
    private var position: (Float, Float, Float)
    private var intrisicState: SharedSpaceShipData
    //...
}
```



<h2 id="proxy">2.5 Proxy</h2>

Problem: additional functionality may be needed while accessing an object (DB for instance. You are not using DB directly)

<u>**Solution**</u>

```swift
class RandomIntWithID {
    var value: Int = {
        print("value initialized")
        return Int.random(in: Int.min...Int.max)
    }()
  
    // property will be initialized only after first call
    lazy var uid: String = {
        print("uid initialized")
        return UUID().uuidString
    }()
}
```



<h2 id="chain">2.6 The Chain of Responsibility</h2>

Problem: you need to handle a request through N handlers. e.g. in authorisation.

**<u>Solution</u>**

Link handlers in one chain. Every handler will have a reference to next handler. So if request will fail on 3rd handler there is no need to use handler after third (obviously).

<h2 id="iterator">2.7 Iterator</h2>

Problem: you want to create class that can be iterated (to use your object in for-in loop)

**<u>Solution</u>**

You need to create structure which implements `IteratorProtocol` and implement `Sequence` protocol in **your** class

```swift
// custom queue which implements protocol Sequence
extension Queue: Sequence {
    
    func makeIterator() -> QueueIterator<T> {
        return QueueIterator(self)
    }
    
}

// queue iterator which helps to iterate through the queue
struct QueueIterator<T>: IteratorProtocol {
    private let queue: Queue<T>
    private var currentNode: Node<T>?
    
    init(_ queue: Queue<T>) {
        self.queue = queue
        currentNode = queue.head
    }
    
    mutating func next() -> T? {
        guard let node = currentNode else { return nil }
        let nextKey = currentNode?.key
        currentNode = node.next
        return nextKey
    }
}
```



<h2 id="observer">2.8 Observer</h2>

Problem: you need to know when some object updates it's state

**<u>Solution</u>**

Subject notifies objects when it's state changed. All objects must implement subject's protocol with `notify()` method

<img src="https://tva1.sinaimg.cn/large/e6c9d24egy1h4tld52o54j20w60ewgmb.jpg" width="600">

```swift
protocol Observer {
    func notify()
    var uid: Int { get }
}
// UIButton - subject
// UILabel - observer
extension UILabel: Observer {
    var uid: Int {
        return ObjectIdentifier(self).hashValue
    }
    func notify() {
        self.text = "Subject state changed"
    }
}

extension UIButton: Subject {
  // register(), unregister() methods
  
  // method to send notification
  func onStateChanged() {
        UIButton.observers.forEach { observer in
            observer.notify()
        }
    }
}
```



<h2 id="state">2.9 State</h2>

Problem: you have a lot of condition statements through which object must pass. Code will increase in size

<u>**Solution**</u>

Identify the states in which your object could be. Create protocol that will be implemented in all object state classes. Use object's state later

```swift
fileprivate protocol CoffeeMachineState {
    func isReadyToBrew() -> Bool
    func brew()
}

// ... default implementstion in CoffeeMachineState extension ...

// state #1
fileprivate struct StandbyState: CoffeeMachineState {
    // your logic    
}

// state #2
fileprivate struct FillWaterTankState: CoffeeMachineState {
    var context: CoffeeMachine
  	// your logic
}
// other states

// main object to controll it's state
class CoffeeMachine {
    // ...
    fileprivate var state: CoffeeMachineState = StandbyState()
}
```

