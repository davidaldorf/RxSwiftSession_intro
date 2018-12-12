import RxSwift

var str = "Hello, playground"
let disposeBag = DisposeBag()

enum ExampleError: Error {
    case rx
}

let one = 1
let two = 2
let three = 3
let error = ExampleError.rx
let observableError = Observable<Any>.error(error)


// MARK: - Creating an Observable

// MARK: - Subscribing on an observable (subscribeToEvent)

// MARK: - Subscribing on a empty observable (emptyObservable)

// MARK: - Other way to create an observable (observableError)

// MARK: - One example of one of the common operators (concat)

playgroundTimeLimit(seconds: 10)
