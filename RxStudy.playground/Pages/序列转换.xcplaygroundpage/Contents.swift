//: [Previous](@previous)

import Foundation
import RxSwift

/*
 example: map
 对每个元素都用函数做一次转换，挨个映射一遍。
 */
example("map") {
    let disposeBag = DisposeBag()
    Observable.of(1, 2, 3)
        .map { $0 * $0 }
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: flatMap and flatMapLatest
 将可观察序列发射的元素转化为可观测序列，并将两个观察到的序列合并为一个可观察序列。
 这是有用的，例如，当你有一个可观察的序列，它本身发射的是可观察的序列，并且你希望能够从
 一个可观察的序列的新的事件作出反应。flatmap和flatmaplatest之间的区别是，
 flatmaplatest只会从最近的可观察序列内发射元素。
 */
example("flatMap and flatMapLatest") {
    let disposeBag = DisposeBag()
    
    struct Player {
        var score: Variable<Int>
    }
    
    let 👦🏻 = Player(score: Variable(80))
    let 👧🏼 = Player(score: Variable(90))
    
    let player = Variable(👦🏻)
    
    player.asObservable()
        .flatMap { $0.score.asObservable() } // Change flatMap to flatMapLatest and observe change in printed output
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
    
    👦🏻.score.value = 85
    
    player.value = 👧🏼
    
    👦🏻.score.value = 95 // Will be printed when using flatMap, but will not be printed when using flatMapLatest
    
    👧🏼.score.value = 100
}

/*
 example: scan
 有点像 reduce ，它会把每次的运算结果累积起来，作为下一次运算的输入值。
 */
example("scan") {
    let disposeBag = DisposeBag()
    
    Observable.of(10, 100, 1000)
        .scan(1) { aggregateValue, newValue in
            aggregateValue + newValue
        }
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}
