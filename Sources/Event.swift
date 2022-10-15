//
//  Created by Carson Rau on 6/6/22.
//

/// A protocol representing any type that can be used as an event.
public protocol EventProtocol: Hashable { }

/// Useful conformance for creating StateMachine without events, i.e. `StateMachine<MyState, Never>`.
extension Never: EventProtocol { }

/// An ``EventProtocol`` wrapper that supports the `any` event.
public enum Event<E: EventProtocol>: Hashable, RawRepresentable {
    // MARK: Event
    /// A specific event value.
    case some(E)
    /// Any event value.
    case any
    
    // MARK: Vars
    /// The hash value for this event.
    public var hashValue: Int {
        switch self {
        case let .some(x):
            return x.hashValue
        case .any:
            return Int.min / 2
        }
    }
    /// The raw value from this event, unwrapped from this type.
    public var rawValue: E? {
        switch self {
        case let .some(x):
            return x
        default:
            return nil
        }
    }
    
    // MARK: Inits
    /// Create a new wrapper around the given raw value. If no value is provided, `any` will be the value of `self`.
    /// - Parameter rawValue: The raw value to wrap within this type.
    public init(rawValue: E?) {
        if let rawValue = rawValue {
            self = .some(rawValue)
        } else {
            self = .any
        }
    }
    
    // MARK: Operators
    /// The equality operator for comparing two event values.
    ///
    /// - Parameters:
    ///   - lhs: The first event value.
    ///   - rhs: The second event value.
    /// - Returns: `true` if the wrapped values are the same, or they are both empty. `false` otherwise.
    public static func == (lhs: Event<E>, rhs: Event<E>) -> Bool {
        switch (lhs, rhs) {
        case let (.some(x1), .some(x2)) where x1 == x2:
            return true
        case (.any, .any):
            return true
        default:
            return false
        }
    }
    /// The equality operator for comparing an event value with a value of the wrapped type.
    ///
    /// - Parameters:
    ///   - lhs: The event value.
    ///   - rhs: The value to compare against the event's wrapped value.
    /// - Returns: `true` if the wrapped value is equivalent to the given value. `false` otherwise.
    public static func == (lhs: Event<E>, rhs: E) -> Bool {
        switch lhs {
        case let .some(x):
            return x == rhs
        case .any:
            return false
        }
    }
    /// The equality operator for comparing an event value with a value of the wrapped type.
    ///
    /// - Parameters:
    ///   - lhs: The value to compare against the event's wrapped value.
    ///   - rhs: The event value.
    /// - Returns: `true` if the wrapped value is equivalent to the given value. `false` otherwise.
    public static func == (lhs: E, rhs: Event<E>) -> Bool {
        switch rhs {
        case let .some(x):
            return x == lhs
        case .any:
            return false
        }
    }
}
