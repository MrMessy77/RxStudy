//: [Previous](@previous)

import Foundation
import RxSwift

/*
 example: catchErrorJustReturn
 通过返回一个可观察到的序列，然后返回一个元素，然后终止。
 */
example("catchErrorJustReturn") {
    let disposeBag = DisposeBag()
    
    let sequenceThatFails = PublishSubject<String>()
    
    sequenceThatFails
        .catchErrorJustReturn("😊")
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
    
    sequenceThatFails.onNext("😬")
    sequenceThatFails.onNext("😨")
    sequenceThatFails.onNext("😡")
    sequenceThatFails.onNext("🔴")
    sequenceThatFails.onError(NSError(domain: "Test", code: -1, userInfo: nil))
}

/*
 example: catchError
 可以捕获异常事件，并且在后面无缝接上另一段事件序列，丝毫没有异常的痕迹。
 */
example("catchError") {
    let disposeBag = DisposeBag()
    
    let sequenceThatFails = PublishSubject<String>()
    let recoverySequence = PublishSubject<String>()
    
    sequenceThatFails
        .catchError {
            print("Error:", $0)
            return recoverySequence
        }
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
    
    sequenceThatFails.onNext("😬")
    sequenceThatFails.onNext("😨")
    sequenceThatFails.onNext("😡")
    sequenceThatFails.onNext("🔴")
    sequenceThatFails.onError(NSError(domain: "Test", code: -1, userInfo: nil))
    
    recoverySequence.onNext("😊")
}

/*
 example: retry
 顾名思义，就是在出现异常的时候会再去从头订阅事件序列，妄图通过『从头再来』解决异常，无限制。
 */
example("retry") {
    let disposeBag = DisposeBag()
    var count = 1
    
    let sequenceThatErrors = Observable<String>.create { observer in
        observer.onNext("🍎")
        observer.onNext("🍐")
        observer.onNext("🍊")
        
        if count == 1 {
            observer.onError(NSError(domain: "Test", code: -1, userInfo: nil))
            print("Error encountered")
            count += 1
        }
        
        observer.onNext("🐶")
        observer.onNext("🐱")
        observer.onNext("🐭")
        observer.onCompleted()
        
        return Disposables.create()
    }
    
    sequenceThatErrors
        .retry()
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: retry maxAttemptCount
 顾名思义，就是在出现异常的时候会再去从头订阅事件序列，妄图通过『从头再来』解决异常，设置最大值来限制重新订阅事件的次数。
 */
example("retry maxAttemptCount") {
    let disposeBag = DisposeBag()
    var count = 1
    
    let sequenceThatErrors = Observable<String>.create { observer in
        observer.onNext("🍎")
        observer.onNext("🍐")
        observer.onNext("🍊")
        
        if count < 5 {
            observer.onError(NSError(domain: "Test", code: -1, userInfo: nil))
            print("Error encountered")
            count += 1
        }
        
        observer.onNext("🐶")
        observer.onNext("🐱")
        observer.onNext("🐭")
        observer.onCompleted()
        
        return Disposables.create()
    }
    
    sequenceThatErrors
        .retry(2)
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}
