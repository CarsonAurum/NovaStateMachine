# ``NovaStateMachine/StateMachine``

## Topics

### Setting Up A Machine
- ``init(state:_:)``
- ``configure(_:)``

### State Changes
- ``canTryState(_:userInfo:)``
- ``tryState(_:userInfo:)``

### Querying Routes
- ``hasRoute(_:userInfo:)``
- ``hasRoute(from:to:userInfo:)``

### Adding Routes
- ``addRoute(_:)``
- ``addRoute(_:condition:)``

### Adding Routes (With Handlers)
- ``addRoute(_:handler:)``
- ``addRoute(_:condition:handler:)``
- ``addRouteChain(_:handler:)``
- ``addRouteChain(_:condition:handler:)``

### Closure-Based Routes
- ``addStateRouteMapping(_:)``
- ``addStateRouteMapping(_:handler:)``

### Adding Handlers
- ``addHandler(_:order:handler:)``
- ``addAnyHandler(_:order:handler:)``
- ``addChainHandler(_:order:handler:)-7u8sb``
- ``addChainHandler(_:order:handler:)-6tmak``
- ``addChainErrorHandler(_:order:handler:)-3gn5c``
- ``addChainErrorHandler(_:order:handler:)-11o59``

### Supporting Types
- ``StateRouteMapping``
