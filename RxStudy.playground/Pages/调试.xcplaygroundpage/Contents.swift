//: [Previous](@previous)

import Foundation
import RxSwift

/*
 example: debug
 打印出所有订阅，事件和disposals。
 */
example("debug") {
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
        .retry(1)
        .debug()
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 RxSwift.Resources.total
 查看RxSwift所有资源的占用，这对于在开发过程中的泄漏检测是有用的。
 */
example("RxSwift.Resources.total") {
//    print(RxSwift.Resources.total)
    
//    let disposeBag = DisposeBag()
//    
//    print(RxSwift.Resources.total)
//    
//    let variable = Variable("🍎")
//    
//    let subscription1 = variable.asObservable().subscribe(onNext: { print($0) })
//    
//    print(RxSwift.Resources.total)
//    
//    let subscription2 = variable.asObservable().subscribe(onNext: { print($0) })
//    
//    print(RxSwift.Resources.total)
//    
//    subscription1.dispose()
//    
//    print(RxSwift.Resources.total)
//    
//    subscription2.dispose()
//    
//    print(RxSwift.Resources.total)
}

