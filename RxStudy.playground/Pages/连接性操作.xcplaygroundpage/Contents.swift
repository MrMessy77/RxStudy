//: [Previous](@previous)

import Foundation
import RxSwift

/*
 Connectable Observable有订阅时不开始发射事件消息，而是仅当调用它们的connect（）方法时。这样就可以等待所有我们想要的订阅者都已经订阅了以后，再开始发出事件消息，这样能保证我们想要的所有订阅者都能接收到事件消息。其实也就是等大家都就位以后，开始发出消息
 */

/*
 example: publish
 将一个正常的序列转换成一个连接性的序列
 */
example("publish") {
    let intSequence = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        .publish()
    
    _ = intSequence
        .subscribe(onNext: { print("Subscription 1:, Event: \($0)") })
    
    delay(2) { _ = intSequence.connect() } //相当于把事件消息推迟了两秒
    
    delay(4) {
        _ = intSequence
            .subscribe(onNext: { print("Subscription 2:, Event: \($0)") })
    }
    
    delay(6) {
        _ = intSequence
            .subscribe(onNext: { print("Subscription 3:, Event: \($0)") })
    }
}

/*
 example: replay
 将一个正常的序列转换成一个连接性的序列，然后和replaySubject相似，能接收到订阅之前的事件消息。
 */
example("replay") {
    let intSequence = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        .replay(5) //接收到订阅之前的5条事件消息
    
    _ = intSequence
        .subscribe(onNext: { print("Subscription 1:, Event: \($0)") })
    
    delay(2) { _ = intSequence.connect() }
    
    delay(4) {
        _ = intSequence
            .subscribe(onNext: { print("Subscription 2:, Event: \($0)") })
    }
    
    delay(8) {
        _ = intSequence
            .subscribe(onNext: { print("Subscription 3:, Event: \($0)") })
    }
}

/*
 example: multicast
 将一个正常的序列转换成一个连接性的序列，并且通过特性的subject发送出去，比如PublishSubject，或者replaySubject，behaviorSubject等。不同的Subject会有不同的结果。
 */
example("multicast") {
    let subject = PublishSubject<Int>()
    
    _ = subject
        .subscribe(onNext: { print("Subject: \($0)") })
    
    let intSequence = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        .multicast(subject)
    
    _ = intSequence
        .subscribe(onNext: { print("\tSubscription 1:, Event: \($0)") })
    
    delay(2) { _ = intSequence.connect() }
    
    delay(4) {
        _ = intSequence
            .subscribe(onNext: { print("\tSubscription 2:, Event: \($0)") })
    }
}