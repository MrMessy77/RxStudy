import Foundation

public func example(_ description: String, action: (Void) -> Void) {
    printExampleHeader(description)
    action()
}

public func printExampleHeader(_ description: String) {
    print("\n--- \(description) ---")
}

public func delay(_ delay:Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
