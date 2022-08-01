# DesignPatterns
This is training project taken from [Practical Design Patterns in Swift](https://www.linkedin.com/learning/practical-design-patterns-in-swift)

<h3>1. Creational Design Patterns</h3>

* [Singleton](#singleton) (ensures that there is only one instance of a type)
* [Prototype](#prototype) (concerned with the cloning of objects)
* [Factory Method](#factory) (creates objects without knowing its exact type)

<h3>2. Structural Design Patterns</h3>

* [Adapter](#adapter) (wraps an incompatible type and exposes an interface that's familiar to the caller)
* Decorator
* Facade
* Flyweight
* Proxy

<h3>3. Behavioral Design Patterns</h3>

* Chain of Responsibility
* Iterator
* Observer
* State

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
