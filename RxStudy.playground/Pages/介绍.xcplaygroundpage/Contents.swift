//: [Previous](@previous)

import Foundation
import RxSwift


/*Observables and observers (aka subscribers)
译：被观测者和观察者（又名订阅者）*/

example("没有用户观察") {
    _ = Observable<String>.create { observerOfString -> Disposable in
        print("这里永远不会被打印")
        observerOfString.on(.next("😬"))
        observerOfString.on(.completed)
        return Disposables.create()
    }
}

example("有用户观察") {
    _ = Observable<String>.create { observerOfString in
        print("观察的对象被创建")
        observerOfString.on(.next("😉"))
        observerOfString.on(.completed)
        return Disposables.create()
        }
        .subscribe { event in
            print(event)
    }
}

//: [Next](@next)
