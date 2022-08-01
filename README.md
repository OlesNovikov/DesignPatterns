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

![image-20220801121659795](/Users/olesnovikov/Library/Application Support/typora-user-images/image-20220801121659795.png)

**<u>Solution 2</u>** (optimized for performance)

Execute code in concurrent queue with reader's right lock
WRITE **.async** with flags **.barrier**. Code won't be processed until all other operations complete
READ **.sync** 

![image-20220801121935056](/Users/olesnovikov/Library/Application Support/typora-user-images/image-20220801121935056.png)

![image-20220801121948846](/Users/olesnovikov/Library/Application Support/typora-user-images/image-20220801121948846.png)
