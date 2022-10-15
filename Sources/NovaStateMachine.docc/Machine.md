# ``NovaStateMachine/Machine``

## Topics

### Setting Up A Machine
- ``init(state:_:)``
- ``configure(_:)``

### State Changes
- ``state``
- ``canTryEvent(_:userInfo:)``
- ``tryEvent(_:userInfo:)``

### Querying Routes
- ``hasRoute(event:transition:userInfo:)``
- ``hasRoute(event:from:to:userInfo:)``

### Adding Routes
- ``addRoutes(event:routes:)-3rtqq``
- ``addRoutes(event:routes:)-q45j``
- ``addRoutes(event:transitions:condition:)-8o39s``
- ``addRoutes(event:transitions:condition:)-8akqd``

### Adding Routes (With Handlers)
- ``addRoutes(event:routes:handler:)-9b445``
- ``addRoutes(event:routes:handler:)-8uogd``
- ``addRoutes(event:transitions:condition:handler:)-9jkop``
- ``addRoutes(event:transitions:condition:handler:)-7joza``

### Closure-Based Routes
- ``addRouteMapping(_:)``
- ``addRouteMapping(_:order:handler:)``

### Adding Handlers
- ``addHandler(event:order:handler:)-8qmid``
- ``addHandler(event:order:handler:)-9ais7``
- ``addErrorHandler(order:handler:)``

### Supporting Types
- ``Context``
- ``Condition``
- ``Handler``
- ``RouteMapping``
