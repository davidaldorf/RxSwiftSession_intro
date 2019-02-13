//: [Previous](@previous)

import RxSwift

let disposeBag = DisposeBag()

/*:
 # Transforming Operators
 Operators that transform Next event elements emitted by an `Observable` sequence.
 ## `map`
 Applies a transforming closure to elements emitted by an `Observable` sequence, and returns a new `Observable` sequence of the transformed elements.
 */
example(of: "map") {
    let disposeBag = DisposeBag()
    Observable.of(1, 2, 3)
        .map { $0 * $0 }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}
/*:
 ----
 ## `flatMap` and `flatMapLatest`
 Transforms the elements emitted by an `Observable` sequence into `Observable` sequences, and merges the emissions from both `Observable` sequences into a single `Observable` sequence. This is also useful when, for example, when you have an `Observable` sequence that itself emits `Observable` sequences, and you want to be able to react to new emissions from either `Observable` sequence. The difference between `flatMap` and `flatMapLatest` is, `flatMapLatest` will only emit elements from the most recent inner `Observable` sequence.
 */
example(of: "flatMap") {
    let outerObservable = Observable<NSInteger>
        .interval(0.5, scheduler: MainScheduler.instance)
        .take(2)
        .debug("🐱")

    let resultObservable = outerObservable.flatMap { outerValue in
        return Observable<NSInteger>
            .interval(0.3, scheduler: MainScheduler.instance)
            .take(3)
            .debug("🐶: \(outerValue)")
    }

    resultObservable
        .subscribe()
        .disposed(by: disposeBag)
    
}
/*:
 > `flatMapLatest` is actually a combination of the `map` and `switchLatest` operators.
 */

example(of: "flatMapLatest") {
    let outerObservable = Observable<NSInteger>
        .interval(0.5, scheduler: MainScheduler.instance)
        .take(2)
        .debug("🐱")

    let combinedObservable = outerObservable.flatMapLatest { outerValue in
        return Observable<NSInteger>
            .interval(0.3, scheduler: MainScheduler.instance)
            .take(3)
            .debug("🐶: \(outerValue)")
    }

    combinedObservable
        .subscribe()
        .disposed(by: disposeBag)
}
/*:
 ----
 ## `scan`
 Begins with an initial seed value, and then applies an accumulator closure to each element emitted by an `Observable` sequence, and returns each intermediate result as a single-element `Observable` sequence.
 */
example(of: "scan") {
    let disposeBag = DisposeBag()
    
    Observable.of(10, 100, 1000)
        .scan(1) { aggregateValue, newValue in
            aggregateValue + newValue
        }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}

//: [Next](@next)
