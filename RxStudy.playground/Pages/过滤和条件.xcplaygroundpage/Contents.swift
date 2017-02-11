//: [Previous](@previous)

import Foundation
import RxSwift

/*
 example: filter
 只会让符合条件的元素通过
 */
example("filter") {
    let disposeBag = DisposeBag()
    
    Observable.of(
        "🐱", "🐰", "🐶",
        "🐸", "🐱", "🐰",
        "🐹", "🐸", "🐱")
        .filter {
            $0 == "🐱"
        }
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: distinctUntilChanged
 抑制可观察序列发出的连续重复元素。
 */
example("distinctUntilChanged") {
    let disposeBag = DisposeBag()
    
    Observable.of("🐱", "🐷", "🐱", "🐱", "🐱", "🐵", "🐱")
        .distinctUntilChanged()
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: elementAt
 只处理在指定位置的事件。
 */
example("elementAt") {
    let disposeBag = DisposeBag()
    
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .elementAt(3)
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: single
 仅由可观察序列发出的第一个元素（或满足条件的第一个元素）。如果观察到的序列发射是不符合条
 件的一个元素，则会抛出一个错误
 */
example("single") {
    let disposeBag = DisposeBag()
    
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .single()
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

example("single with conditions") {
    let disposeBag = DisposeBag()
    
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .single { $0 == "🐸" }
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
    
    Observable.of("🐱", "🐰", "🐶", "🐱", "🐰", "🐶")
        .single { $0 == "🐰" }
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
    
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .single { $0 == "🔵" }
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
}

/*
 example: take
 从可观察序列的开始仅释放指定数量的元素。
 */
example("take") {
    let disposeBag = DisposeBag()
    
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .take(4)
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: takeLast
 仅从可观察序列的结束处释放指定数量的元素。
 */
example("takeLast") {
    let disposeBag = DisposeBag()
    
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .takeLast(3)
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: takeWhile
 只要指定的条件计算为true，从可观察序列的开始发出元素。
 */
example("takeWhile") {
    let disposeBag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5, 6)
        .takeWhile { $0 < 4 }
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: takeUntil
 接收事件消息，直到另一个可观察序列发出事件消息的时候。
 */
example("takeUntil") {
    let disposeBag = DisposeBag()
    
    let sourceSequence = PublishSubject<String>()
    let referenceSequence = PublishSubject<String>()
    
    sourceSequence
        .takeUntil(referenceSequence)
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
    
    sourceSequence.onNext("🐱")
    sourceSequence.onNext("🐰")
    sourceSequence.onNext("🐶")
    
    referenceSequence.onNext("🔴")
    
    sourceSequence.onNext("🐸")
    sourceSequence.onNext("🐷")
    sourceSequence.onNext("🐵")
}

/*
 example: skip
 禁止从可观察序列的开始发射指定数量的元素。
 */
example("skip") {
    let disposeBag = DisposeBag()
    
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .skip(2)
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: skipWhile
 抑制从符合指定条件的可观察序列的开始发射元素。
 */
example("skipWhile") {
    let disposeBag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5, 6)
        .skipWhile { $0 < 4 }
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: skipWhileWithIndex
 抑制从符合指定条件的可观察序列的开始发射元素，并释放剩余元素。闭包也传递了每个元素的索
 引。
 */
example("skipWhileWithIndex") {
    let disposeBag = DisposeBag()
    
    Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
        .skipWhileWithIndex { element, index in
            index < 3
        }
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: skipUntil
 直到某个可观察序列发出了事件消息，才开始接收当前序列发出的事件消息。
 */
example("skipUntil") {
    let disposeBag = DisposeBag()
    
    let sourceSequence = PublishSubject<String>()
    let referenceSequence = PublishSubject<String>()
    
    sourceSequence
        .skipUntil(referenceSequence)
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
    
    sourceSequence.onNext("🐱")
    sourceSequence.onNext("🐰")
    sourceSequence.onNext("🐶")
    
    referenceSequence.onNext("🔴")
    
    sourceSequence.onNext("🐸")
    sourceSequence.onNext("🐷")
    sourceSequence.onNext("🐵")
}
