//
//  Created by Carson Rau on 6/6/22.
//

import NovaCore

public struct Route<S: StateProtocol, E: EventProtocol> {
    public let transition: Transition<S>
    public let condition: Machine<S, E>.Condition?
    public init(transition: Transition<S>, condition: Machine<S, E>.Condition?) {
        self.transition = transition
        self.condition = condition
    }
    
}

public func => <S, E>(lhs: [S], rhs: S) -> Route<S, E> {
    lhs => .some(rhs)
}
public func => <S, E>(lhs: S, rhs: [S]) -> Route<S, E> {
    .some(lhs) => rhs
}
public func => <S, E>(lhs: [S], rhs: [S]) -> Route<S, E> {
    .init(transition: .any => .any) { lhs.contains($0.from) && rhs.contains($0.to) }
}



// MARK: - RouteChain

public struct RouteChain<S: StateProtocol, E: EventProtocol> {
    public private(set) var routes: [Route<S, E>]
    public init(routes: [Route<S, E>]) {
        self.routes = routes
    }
    public init(transitions chain: TransitionChain<S>, condition: Machine<S, E>.Condition? = nil) {
        var rs: [Route<S, E>] = []
        for transition in chain.transitions {
            rs += .init(transition: transition, condition: condition)
        }
        self.init(routes: rs)
    }
}
