import RxSwift
import Pods_RxSwift_sessions_intro

// NOTES:::

// MARK: - RxOperators intro

//Recap

let disposeBag = DisposeBag()

enum ExampleError: Error {
    case rx
}

let one = 1
let two = 2
let three = 3
let error = ExampleError.rx
let observableError = Observable<Any>.error(error)

example(of: "just, of, from") {
    
    let observableJust: Observable<Int> = Observable<Int>.just(one)
    let observableOf = Observable.of(one, two, three)
    let observableFrom = Observable.from([one, two, three, observableError])
}

example(of: "Subscribe to events") {
    let subscribeToEvent = Observable.from([one, two, three, error])
    subscribeToEvent.subscribe { event in
        switch event {
        case .next:
            print("next: \(event)")
        case .completed:
            print("next: \(event)")
        case .error:
            print("next: \(event)")
        }
    }
}

// debug()
example(of: "debug()") {
    
    let debugObservable = Observable.of(one, two, three)
    
    debugObservable
        .debug()
        .subscribe { event in
//            print(event)
    }
}

//: [Next](@next)
