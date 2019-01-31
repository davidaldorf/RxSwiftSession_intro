import RxSwift
import RxCocoa

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
//example(of: "Observable with error") {
//    let example = Observable<Int>.create { observer in
//        /// Customize observable
//        observer.onNext(1)
//        observer.onNext(2)
//        observer.onNext(4)
//        observer.onNext(5)
//        observer.onError(error)
//
//        observer.onCompleted()
//
//        return Disposables.create()
//    }
//(
//    example.subscribe { event in
//        switch event {
//        case .next(let value) :
//            print(value)
//        case .error(let error):
//            print("Error \(error)")
//        case .completed:
//            print("completed")
//        }
//    }
//})

// MARK: - One example of one of the common operators (concat)
example(of: "Observable.concat") {
    // 1
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)

    BehaviorSubject(value: "")
    
    // 2
    let observable = Observable.concat([first, second])
    observable.asDriver(onErrorJustReturn: 1)
    let view = UILabel()
    
    observable.subscribe { event in
        print(event)
    }
    
    let observable2 = Observable<String>.create { observer -> Disposable in
        observer.onCompleted()
        return Disposables.create()
    }
    
    let signal = observable2.asSignal(onErrorJustReturn: "")
    observable2.asDriver(onErrorJustReturn: "").drive(onNext: { value in
        print(value)
    }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    
    signal.asDriver(onErrorJustReturn: "").drive(view.rx.text)
    
    
    let button = UIButton()
    print(button.isEnabled)
    let boolObservable = Observable<Bool>.create({ (observer) -> Disposable in
        return Disposables.create {}
    })
    boolObservable.bind(to: button.rx.isEnabled)
    
//    let boolSubject = BehaviorRelay(value: false)
//    boolSubject.asDriver(onErrorJustReturn: false).drive(button.rx.isEnabled)
//        .disposed(by: disposeBag)
//    print(button.isEnabled) // false
    
    boolObservable.asDriver(onErrorJustReturn: false).drive(button.rx.isEnabled)
    .disposed(by: disposeBag)
    print(button.isEnabled) // true
    
    observable2.asDriver(onErrorJustReturn: "").drive(view.rx.text)
    print("aaa", view.text)
//    observable2.asDriver(onErrorJustReturn: "").drive(view.rx.text).disposed(by: disposeBag)
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
