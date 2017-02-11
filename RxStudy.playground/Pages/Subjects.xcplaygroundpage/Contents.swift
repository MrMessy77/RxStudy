//: [Previous](@previous)

import Cocoa
import RxSwift

/* 创建这个方法便于打印信息 */
func writeSequenceToConsole<O: ObservableType>(name: String, sequence: O) -> Disposable {
    return sequence.subscribe { event in
        print("Subscription: \(name), event: \(event)")
    }
}
/*
 Subject
 可以看做是一种代理和桥梁。它既是订阅者又是订阅源，这意味着它既可以订阅其他 Observable 对象，
 同时又可以对它的订阅者们发送事件.
 */

/*
 example: PublishSubject
 在订阅时间内向所有观察者发送新事件。
 */
example("PublishSubject") {
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()
    
    writeSequenceToConsole(name: "1", sequence: subject).addDisposableTo(disposeBag)
    subject.onNext("🐶")
    subject.onNext("🐱")
    
    writeSequenceToConsole(name: "2", sequence: subject).addDisposableTo(disposeBag)
    subject.onNext("🅰️")
    subject.onNext("🅱️")
}

/*
 example: ReplaySubject
 发送新的事件给所有的观察者，并指定先前事件缓存区的大小给新的观察者。
 */
example("ReplaySubject") {
    let disposeBag = DisposeBag()
    let subject = ReplaySubject<String>.create(bufferSize: 1)
    
    writeSequenceToConsole(name: "1", sequence: subject).addDisposableTo(disposeBag)
    subject.onNext("🐶")
    subject.onNext("🐱")
    
    writeSequenceToConsole(name: "2", sequence: subject).addDisposableTo(disposeBag)
    subject.onNext("🅰️")
    subject.onNext("🅱️")
}

/*
 example: BehaviorSubject
 发送新的事件给所有的观察者，并向新的观察者发送最近的一个事件，没有则发送默认值。
 */
example("BehaviorSubject") {
    let disposeBag = DisposeBag()
    let subject = BehaviorSubject(value: "🔴")
    
    writeSequenceToConsole(name: "1", sequence: subject).addDisposableTo(disposeBag)
    subject.onNext("🐶")
    subject.onNext("🐱")
    
    writeSequenceToConsole(name: "2", sequence: subject).addDisposableTo(disposeBag)
    subject.onNext("🅰️")
    subject.onNext("🅱️")
}

/*
 example: Variable
 BehaviorSubject的进一步封装，所以会发送最近的事件给新的订阅者。但不会收到 .Completed 和 .Error 这类的终结事件，它会主动在析构的时候发送 .Complete。
 */
example("Variable") {
    let disposeBag = DisposeBag()
    let variable = Variable("🔴")
    
    writeSequenceToConsole(name: "1", sequence: variable.asObservable()).addDisposableTo(disposeBag)
    variable.value = "🐶"
    variable.value = "🐱"
    
    writeSequenceToConsole(name: "2", sequence: variable.asObservable()).addDisposableTo(disposeBag)
    variable.value = "🅰️"
    variable.value = "🅱️"
}
