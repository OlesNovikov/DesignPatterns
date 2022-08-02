// Custom queue implementation

private final class Node<T> {
    var key: T?
    var next: Node?
    
    init(_ value: T? = nil) {
        key = value
    }
}

final class Queue<T> {
    fileprivate var head: Node<T>?
    private var tail: Node<T>?
    
    func enqueue(_ value: T) {
        let newNode = Node<T>(value)
        // First element's value has not been set?
        guard head != nil else {
            head = newNode
            tail = head
            return
        }

        // append new element
        tail?.next = newNode
        tail = newNode
    }
    
    func dequeue() -> T? {
        guard let headItem = head?.key else {
            return nil
        }
        
        if let nextNode = head?.next {
            head = nextNode
        } else {
            head = nil
            tail = nil
        }
        return headItem
    }
    
    func isEmpty() -> Bool {
        return head == nil
    }
    
    func peek() -> T? {
        return head?.key
    }
}

var queue = Queue<Int>()
queue.enqueue(1)
queue.enqueue(2)

for item in queue {
    print(item)
}
