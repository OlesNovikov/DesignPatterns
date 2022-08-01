class NameClass {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension NameClass: CustomStringConvertible {
    public var description: String {
        return "NameClass(firstName: \"\(firstName)\", lastName: \"\(lastName)\")"
    }
}

var steve = NameClass(firstName: "Steve", lastName: "Johnson")
var john = steve

print("\(steve), \(john)")

john.firstName = "John"
john.lastName = "Wallace"

print("\(steve), \(john)")
