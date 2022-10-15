//
//  Created by Carson Rau on 6/6/22.
//

import NovaCore

// MARK: - Transition

public struct Transition<S: StateProtocol>: Hashable, CustomStringConvertible {
    public let from: State<S>
    public let to: State<S>
    public var description: String {
        "\(self.from) => \(self.to) (\(self.hashValue))"
    }
    // MARK: Init
    public init(from: State<S>, to: State<S>) {
        self.from = from
        self.to = to
    }
    public init(from: S, to: State<S>) {
        self.from = .some(from)
        self.to = to
    }
    public init(from: State<S>, to: S) {
        self.from = from
        self.to = .some(to)
    }
    public init(from: S, to: S) {
        self.from = .some(from)
        self.to = .some(to)
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(from.hashValue)
        hasher.combine(to.hashValue)
    }
    // MARK: Operators
    public static func == (lhs: Transition<S>, rhs: Transition<S>) -> Bool {
        lhs.from == rhs.from && lhs.to == rhs.to
    }
    public static func => (lhs: Transition<S>, rhs: State<S>) -> TransitionChain<S> {
        .init(states: [lhs.from, lhs.to]) => rhs
    }
    public static func => (lhs: Transition<S>, rhs: S) -> TransitionChain<S> {
        lhs => .some(rhs)
    }
    public static func => (lhs: State<S>, rhs: Transition<S>) -> TransitionChain<S> {
        lhs => .init(states: [rhs.from, rhs.to])
    }
    public static func => (lhs: S, rhs: Transition<S>) -> TransitionChain<S> {
        .some(lhs) => rhs
    }
}

public func => <S>(lhs: S, rhs: S) -> Transition<S> {
    .init(from: .some(lhs), to: .some(rhs))
}

// MARK: - TransitionChain

public struct TransitionChain<S: StateProtocol> {
    public private(set) var states: [State<S>]
    public var transitions: [Transition<S>] {
        var result: [Transition<S>] = []
        for i in 0 ..< states.count - 1 {
            result += states[i] => states[i+1]
        }
        return result
    }
    public init(states: [State<S>]) {
        self.states = states
    }
    public init(transition: Transition<S>) {
        self.init(states: [transition.from, transition.to])
    }
    public static func => (lhs: TransitionChain<S>, rhs: State<S>) -> TransitionChain<S> {
        .init(states: lhs.states + rhs)
    }
    public static func => (lhs: TransitionChain<S>, rhs: S) -> TransitionChain<S> {
        lhs => .some(rhs)
    }
    public static func => (lhs: State<S>, rhs: TransitionChain<S>) -> TransitionChain<S> {
        .init(states: lhs + rhs.states)
    }
    public static func => (lhs: S, rhs: TransitionChain<S>) -> TransitionChain<S> {
        .some(lhs) => rhs
    }
}
