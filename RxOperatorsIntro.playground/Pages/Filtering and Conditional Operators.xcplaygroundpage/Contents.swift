//: [Previous](@previous)

import RxSwift

let disposeBag = DisposeBag()
/*:
 # Filtering and Conditional Operators
 Operators that selectively emit elements from a source `Observable` sequence.
 ## `filter`
 Emits only those elements from an `Observable` sequence that meet the specified condition.
 */
example(of: "filter") {
    Observable.of(
        "🐱", "🐰", "🐶",
        "🐸", "🐱", "🐰",
        "🐹", "🐸", "🐱")
        .filter {
            $0 == "🐱"
        }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}
/*:
 ----
 ## `distinctUntilChanged`
 Suppresses sequential duplicate elements emitted by an `Observable` sequence.
 */
example(of: "distinctUntilChanged") {
    Observable.of("🐱", "🐷", "🐱", "🐱", "🐱", "🐵", "🐱")
        .distinctUntilChanged()
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}
/*:
 ----
 ## `take`
 Emits only the specified number of elements from the beginning of an `Observable` sequence.
 */
example(of: "take") {
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .take(3)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}
/*:
 ----
 ## `takeLast`
 Emits only the specified number of elements from the end of an `Observable` sequence.
 */
example(of: "takeLast") {
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .takeLast(3)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}
/*:
 ----
 ## `takeWhile`
 Emits elements from the beginning of an `Observable` sequence as long as the specified condition evaluates to `true`.
 */
example(of: "takeWhile") {
    let disposeBag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5, 6)
        .takeWhile { $0 < 4 }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}
/*:
 ----
 ## `takeUntil`
 Emits elements from a source `Observable` sequence until a reference `Observable` sequence emits an element.
 */
example(of: "takeUntil") {
    let sourceSequence = PublishSubject<String>()
    let referenceSequence = PublishSubject<String>()
    
    sourceSequence
        .takeUntil(referenceSequence)
        .subscribe { print($0) }
        .disposed(by: disposeBag)
    
    sourceSequence.onNext("🐱")
    sourceSequence.onNext("🐰")
    sourceSequence.onNext("🐶")
    
    referenceSequence.onNext("🔴")
    
    sourceSequence.onNext("🐸")
    sourceSequence.onNext("🐷")
    sourceSequence.onNext("🐵")
}
/*:
 ----
 ## `skip`
 Suppresses emitting the specified number of elements from the beginning of an `Observable` sequence.
 */
example(of: "skip") {
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .skip(2)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}
/*:
 ----
 ## `skipWhile`
 Suppresses emitting the elements from the beginning of an `Observable` sequence that meet the specified condition.
 */
example(of: "skipWhile") {
    Observable.of(1, 2, 3, 4, 5, 6)
        .skipWhile { $0 < 4 }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}
/*:
 ----
 ## `skipWhileWithIndex`
 Suppresses emitting the elements from the beginning of an `Observable` sequence that meet the specified condition, and emits the remaining elements. The closure is also passed each element's index.
 */
example(of: "skipWhileWithIndex") {
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .skipWhileWithIndex { element, index in
            index < 3
        }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}
/*:
 ----
 ## `skipUntil`
 Suppresses emitting the elements from a source `Observable` sequence until a reference `Observable` sequence emits an element.
 */
example(of: "skipUntil") {
    let sourceSequence = PublishSubject<String>()
    let referenceSequence = PublishSubject<String>()
    
    sourceSequence
        .skipUntil(referenceSequence)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    
    sourceSequence.onNext("🐱")
    sourceSequence.onNext("🐰")
    sourceSequence.onNext("🐶")
    
    referenceSequence.onNext("🔴")
    
    sourceSequence.onNext("🐸")
    sourceSequence.onNext("🐷")
    sourceSequence.onNext("🐵")
}

//: [Next](@next)
