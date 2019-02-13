//: [Previous](@previous)

import RxSwift

let disposeBag = DisposeBag()

/*:
 # Combination Operators
 Operators that combine multiple source `Observable`s into a single `Observable`.
 ## `startWith`
 Emits the specified sequence of elements before beginning to emit the elements from the source `Observable`.
 */
example(of: "startWith") {
    let disposeBag = DisposeBag()
    
    Observable.of("🐶", "🐱", "🐭", "🐹")
        .startWith("1️⃣")
        .startWith("2️⃣")
        .startWith("3️⃣", "🅰️", "🅱️")
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
}
/*:
 > As this example demonstrates, `startWith` can be chained on a last-in-first-out basis, i.e., each successive `startWith`'s elements will be prepended before the prior `startWith`'s elements.
 ----
 ## `merge`
 Combines elements from source `Observable` sequences into a single new `Observable` sequence, and will emit each element as it is emitted by each source `Observable` sequence.
 */
example(of: "merge") {
    let disposeBag = DisposeBag()
    
    let subject1 = PublishSubject<String>()
    let subject2 = PublishSubject<String>()
    
    Observable.of(subject1, subject2)
        .merge()
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    
    subject1.onNext("🅰️")
    
    subject1.onNext("🅱️")
    
    subject2.onNext("①")
    
    subject2.onNext("②")
    
    subject1.onNext("🆎")
    
    subject2.onNext("③")
}
/*:
 ----
 ## `zip`
 Combines up to 8 source `Observable` sequences into a single new `Observable` sequence, and will emit from the combined `Observable` sequence the elements from each of the source `Observable` sequences at the corresponding index.
 */
//example(of: "zip") {
//    let catObservable = Observable<NSInteger>
//        .interval(0.5, scheduler: MainScheduler.instance)
//        .take(5)
//        .debug("🐱")
//
//    let dogObservable = Observable<NSInteger>
//        .interval(0.3, scheduler: MainScheduler.instance)
//        .take(5)
//        .debug("🐶")
//    
//    Observable.zip(catObservable, dogObservable)
//        .subscribe(onNext: { (cat, dog) in
//            print("🐱: \(cat) 🐶: \(dog)")
//        })
//        .disposed(by: disposeBag)
//}
/*:
 ----
 ## `combineLatest`
 Combines up to 8 source `Observable` sequences into a single new `Observable` sequence, and will begin emitting from the combined `Observable` sequence the latest elements of each source `Observable` sequence once all source sequences have emitted at least one element, and also when any of the source `Observable` sequences emits a new element.
 */
example(of: "combineLatest") {
    let catObservable = Observable<NSInteger>
        .interval(0.5, scheduler: MainScheduler.instance)
        .take(5)
        .debug("🐱")

    let dogObservable = Observable<NSInteger>
        .interval(0.3, scheduler: MainScheduler.instance)
        .take(5)
        .debug("🐶")

    Observable.combineLatest(catObservable, dogObservable)
        .subscribe(onNext: { (cat, dog) in
            print("🐱: \(cat) 🐶: \(dog)")
        })
        .disposed(by: disposeBag)
}

//: [Next](@next)
