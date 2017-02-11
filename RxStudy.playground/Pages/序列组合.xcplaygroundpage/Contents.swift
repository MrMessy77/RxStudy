//: [Previous](@previous)

import Foundation
import RxSwift

/*
 序列组合
 */


/*
 example: startWith
 在从被观察者发送事件开始之前，先发送指定的元素序列。
 */
example("startWith") {
    let disposeBag = DisposeBag()
    
    Observable.of("4", "5", "6", "7")
        .startWith("3")
        .startWith("2")
        .startWith("1")
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: merge
 将两个可观察序列按照顺序组合在一起,形成一个新的可观察序列。
 */
example("merge") {
    let disposeBag = DisposeBag()
    
    let subject1 = PublishSubject<String>()
    let subject2 = PublishSubject<String>()
    
    Observable.of(subject1, subject2)
        .merge()
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
    
    subject1.onNext("1")
    
    subject1.onNext("2")
    
    subject2.onNext("3")
    
    subject2.onNext("4")
    
    subject1.onNext("5")
    
    subject2.onNext("6")
}

/*
 example: zip
 将两个可观察序列按照顺序组合在一起,形成一个新的可观察序列,并一一对应。
 */
example("zip") {
    let disposeBag = DisposeBag()
    
    let stringSubject = PublishSubject<String>()
    let intSubject = PublishSubject<String>()
    
    Observable.zip(stringSubject, intSubject) { stringElement, intElement in
        "\(stringElement) \(intElement)"
        }
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
    
    stringSubject.onNext("1")
    stringSubject.onNext("2")
    
    intSubject.onNext("A")
    
    intSubject.onNext("B")
    
    stringSubject.onNext("3")
    intSubject.onNext("C")
}

/*
 example: combineLatest
 如果存在最多不超过8条的事件序列，需要同时监听，那么每当有新的事件发生的时候，combineLatest 会将每个序列的最新的一个元素进行合并。
 */
example("combineLatest") {
    let disposeBag = DisposeBag()
    
    let stringSubject = PublishSubject<String>()
    let intSubject = PublishSubject<Int>()
    
    Observable.combineLatest(stringSubject, intSubject) { stringElement, intElement in
        "\(stringElement) \(intElement)"
        }
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
    
    stringSubject.onNext("🅰️")
    
    stringSubject.onNext("🅱️")
    intSubject.onNext(1)
    
    intSubject.onNext(2)
    
    stringSubject.onNext("🆎")
}

/*
 example: switchLatest
 将可观察序列发出的事件转换成可观察的序列，并从最近的可观察序列中发送事件。
 */
example("switchLatest") {
    let disposeBag = DisposeBag()
    
    let subject1 = BehaviorSubject(value: "⚽️")
    let subject2 = BehaviorSubject(value: "🍎")
    
    let variable = Variable(subject1)
    
    variable.asObservable()
        .switchLatest()
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
    
    subject1.onNext("🏈")
    subject1.onNext("🏀")
    
    variable.value = subject2
    
    subject1.onNext("⚾️")
    
    subject2.onNext("🍐")
}
