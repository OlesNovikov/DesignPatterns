# DesignPatterns
This is training project taken from [Practical Design Patterns in Swift](https://www.linkedin.com/learning/practical-design-patterns-in-swift)

<h3>1. Creational Design Patterns</h3>

* Singleton (ensures that there is only one instance of a type)
* Prototype (concerned with the cloning of objects)
* Factory Method (creates objects without knowing its exact type)

<h3>2. Structural Design Patterns</h3>

* Adapter
* Decorator
* Facade
* Flyweight
* Proxy

<h3>3. Behavioral Design Patterns</h3>

* Chain of Responsibility
* Iterator
* Observer
* State

<h4>1.1 Singleton</h4>

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

