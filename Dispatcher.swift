import Foundation

typealias DispatchAction = () -> ()

class Dispatcher {
    
    private var dispatchItem: DispatchWorkItem?
    private let dispatchTimeout: TimeInterval
    private let dispatchQueue: DispatchQueue
    
    init(dispatchTimeout: TimeInterval, dispatchQueue: DispatchQueue = .main) {
        self.dispatchTimeout = dispatchTimeout
        self.dispatchQueue = dispatchQueue
    }
    
    func action(_ action: @escaping DispatchAction, dispatchQueue: DispatchQueue? = nil) {
        self.dispatchItem = DispatchWorkItem(block: action)
        (dispatchQueue ?? self.dispatchQueue).asyncAfter(deadline: .now() + dispatchTimeout, execute: self.dispatchItem!)
    }
    
    func cancel() {
        self.dispatchItem?.cancel()
    }
}
