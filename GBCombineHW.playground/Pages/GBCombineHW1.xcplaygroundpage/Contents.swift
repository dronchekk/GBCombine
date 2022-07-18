//: [Previous](@previous)

import Foundation
import Combine

// 1.

let namesPublisher = ["Andrew", "Vasya", "David"].publisher

// 2.

final class GreetingSubscriber: Subscriber {
    typealias Input = String
    typealias Failure = Never

    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    func receive(_ input: String) -> Subscribers.Demand {
        let greetingOutput = "Hello, \(input)!"
        print(greetingOutput)
        return .none
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("Completion received: \(completion).")
    }
}

let greetingSubscriber = GreetingSubscriber()
namesPublisher.subscribe(greetingSubscriber)

// 3.

struct MySwitch {
    enum State { case on, off }
    let subject = CurrentValueSubject<State, Never>(.off)

    func toggle() {
        subject.send(subject.value == .on ? .off : .on)
    }
}

let mySwitch = MySwitch()

mySwitch.subject.sink { switchState in
    print("Switch is now \(switchState).")
}

mySwitch.toggle()
mySwitch.toggle()
mySwitch.toggle()
mySwitch.toggle()
mySwitch.toggle()
mySwitch.subject.send(.off)

//: [Next](@next)
