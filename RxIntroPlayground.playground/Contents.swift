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


// MARK: - Creating an Observable (justOfFrom)
example(of: "just, of, from, empty") {

    let observableJust: Observable<Int> = Observable<Int>.just(one)
    let observableOf = Observable.of(one, two, three)
    let observableFrom = Observable.from([one, two, three, observableError])
    let observableEmpty = Observable<Int>.empty()
}

// MARK: - Subscribing on an observable (subscribeToEvent)
example(of: "Subscribe to events") {
    let subscribeToEvent = Observable.from([one, two, three])
    subscribeToEvent.subscribe { event in
        print(event)

    }
}
// MARK: - Subscribing on a empty observable (emptyObservable)
example(of: "empty") {
    let observableEmpty = Observable<Int>.empty()
    observableEmpty.subscribe { event in
        print(event)
    }
}
// MARK: - Other way to create an observable (observableError)
example(of: "Observable with error") {
    let example = Observable<Int>.create { observer in
        /// Customize observable
        observer.onNext(1)
        observer.onNext(2)
        observer.onNext(4)
        observer.onNext(5)
        observer.onError(error)

        observer.onCompleted()

        return Disposables.create()
    }

    example.subscribe { event in
        switch event {
        case .next(let value) :
            print(value)
        case .error(let error):
            print("Error \(error)")
        case .completed:
            print("completed")
        }
    }
}

// MARK: - One example of one of the common operators (concat)
example(of: "Observable.concat") {
    // 1
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)

    // 2
    let observable = Observable.concat([first, second])

    observable.subscribe { event in
        print(event)
    }
}


example(of: "concat") {
    let germanCities = Observable.of("Berlin", "Munich", "Frankfurt")
    let spanishCities = Observable.of("Madrid", "Barcelona", "Valencia")

    let observable = germanCities.concat(spanishCities)
    observable.subscribe { event in
        print(event)
    }
}
playgroundTimeLimit(seconds: 10)
