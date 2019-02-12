import RxSwift
import Pods_RxSwift_sessions_intro

// NOTES:::

// MARK: - RxOperators intro

//Recap

let disposeBag = DisposeBag()

enum ExampleError: Error {
    case WTF
}

let one = 1
let two = 2
let three = 3
let error = ExampleError.WTF
let observableError = Observable<Any>.error(error)

/*:
 ----
 ## `Creating Observables`
 */

example(of: "just, of, from") {

    let observableJust: Observable<Int> = Observable<Int>.just(one)
    let observableError: Observable<Int> = Observable.error(ExampleError.WTF)
    let observableOf = Observable.of(one, two, three)
    let observableFrom = Observable.from([one, two, three])
    
    let observable = Observable<Int>.create { observer -> Disposable in
        let numbers = [one, two, three]
        numbers.forEach {
            observer.on(.next($0))
        }

        observer.on(.completed)

        return Disposables.create()
    }
}

example(of: "Subscribe to events") {

    let observable = Observable<Int>.create { observer -> Disposable in
        let numbers = [one, two, three]
        numbers.forEach {
            observer.on(.next($0))
        }

        // observer.on(.completed)
        observer.on(.error(ExampleError.WTF))

        return Disposables.create()
    }

    observable.subscribe { event in
        switch event {
        case .next:
            print(event)
        case .completed:
            print(event)
        case .error:
            print(event)
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
