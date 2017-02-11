//: [Previous](@previous)

import Foundation
import RxSwift

/*
 example: toArray
 将可观察的序列转换为数组，将该数组作为新的元素通过可观察序列发出，然后终止。
 */
example("toArray") {
    let disposeBag = DisposeBag()
    
    Observable.range(start: 1, count: 10)
        .toArray()
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
}

/*
 example: reduce
 从初始值开始，然后将累加器闭包应用于可观察序列发出的所有元素，并将聚合结果返回为单个
 元素可观察序列。
 */
example("reduce") {
    let disposeBag = DisposeBag()
    
    Observable.of(10, 100, 1000)
        .reduce(1, accumulator: +)
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: concat
 concat会把多个序列和并为一个序列，并且当前面一个序列发出了completed事件，才会开始下一
 个序列的事件。
 */
example("concat") {
    let disposeBag = DisposeBag()
    
    let subject1 = BehaviorSubject(value: "🍎")
    let subject2 = BehaviorSubject(value: "🐶")
    
    let variable = Variable(subject1)
    
    variable.asObservable()
        .concat()
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
    
    subject1.onNext("🍐")
    subject1.onNext("🍊")
    
    variable.value = subject2
    
    subject2.onNext("I would be ignored")
    subject2.onNext("🐱")
    
    subject1.onCompleted()
    
    subject2.onNext("🐭")
}
