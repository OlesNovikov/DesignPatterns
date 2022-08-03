import Foundation

protocol RequestHandling {
    init(next: RequestHandling?)
    
    func handle(request: Any)
}

final class Handler<T>: RequestHandling, CustomStringConvertible {
    private var nextHandler: RequestHandling?
    
    init(next: RequestHandling?) {
        self.nextHandler = next
    }
    
    func handle(request: Any) {
        if request is T {
            print("Request processed by \(self)")
        } else {
            guard let handler = nextHandler else {
                print("Reached the end of the responder chain")
                return
            }
            handler.handle(request: request)
            print("\(self) can't handle \(T.self) requests - forwarding to \(handler)")
        }
    }
    
    public var description: String {
        return "\(T.self) Handler"
    }
}


let dataHandler = Handler<Data>(next: nil)
let stringHandler = Handler<String>(next: dataHandler)
let dateHandler = Handler<Date>(next: stringHandler)

let data = Data(repeating: 0, count: 10)
dateHandler.handle(request: data)

dateHandler.handle(request: 42)
