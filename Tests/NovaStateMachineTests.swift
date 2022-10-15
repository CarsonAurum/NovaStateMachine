import XCTest
@testable import NovaStateMachine

enum MachineState: StateProtocol {
    case s0, s1, s2
}

enum MachineEvent: EventProtocol {
    case e0, e1, e2
}

final class NovaStateMachineTests: XCTestCase {
    func testStateMachine() {
        let machine = StateMachine<MachineState, Never>(state: .s0) {
            $0.addRoute(.s0 => .s1)
            $0.addRoute(.any => .s2) { print("Any => 2, msg=\(String(describing: $0.userInfo))") }
            $0.addRoute(.s2 => .any) { print("2 => Any, msg=\(String(describing: $0.userInfo))") }
            $0.addHandler(.s0 => .s1) { _ in print("0 => 1") }
            $0.addErrorHandler { print("[ERROR] \($0.from) => \($0.to)") }
        }
        
        // initial
        XCTAssertEqual(machine.state, .s0)
        // tryState 0 => 1 => 2 => 1 => 0
        machine <- .s1
        XCTAssertEqual(machine.state, .s1)
        machine <- (.s2, "Hello")
        XCTAssertEqual(machine.state, .s2)
        machine <- (.s1, "Bye")
        XCTAssertEqual(machine.state, .s1)
        machine <- .s0  // fail: no 1 => 0
        XCTAssertEqual(machine.state, .s1)
    }
}
