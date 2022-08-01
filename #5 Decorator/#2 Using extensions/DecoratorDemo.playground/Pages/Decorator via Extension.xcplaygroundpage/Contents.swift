import Foundation

extension UserDefaults {
    
    func set(date: Date?, forKey key: String) {
        self.set(date, forKey: key)
    }
    
    func date(forKey key: String) -> Date? {
        return self.value(forKey: key) as? Date
    }
    
}

let userDefaults = UserDefaults.standard
userDefaults.set(date: Date(), forKey: "now")

print(userDefaults.date(forKey: "now") ?? "?")
