//: Playground - noun: a place where people can play

import Cocoa
import RxSwift

/*
 example: never
 创建一个永不终止并且永不发送任何事件的序列
 */
example("never:没有任何元素、也不会发送任何事件的空序列") {
    let disposeBag = DisposeBag()
    let neverSequence = Observable<Int>.never()
    
    let subscription = neverSequence.subscribe({ (event) in
        print("这里永远不会被打印")
    })
    
    subscription.addDisposableTo(disposeBag)
}

/*
 example: empty
 创建一个只发送.Completed事件的空序列
 */
example("empty:没有任何元素、只发送.Completed事件的空序列") {
    let disposeBag = DisposeBag()
    
    Observable<String>.empty() //create sequence
        .subscribe { event in  //subscribe sequence
            print(event)
        }
        .addDisposableTo(disposeBag)
}

/*
 example: just
 创建一个只包含一个元素的序列
 */
example("just:一个只包含一个元素的序列") {
    let disposeBag = DisposeBag()

    Observable<Int>.just(2)
        .subscribe{ event in
            print(event)
        }
        .addDisposableTo(disposeBag)
}

/*
 example: of
 创建一个包含固定数量的元素的序列
 */
example("of:一个包含固定数量的元素的序列") {
    let disposeBag = DisposeBag()
    
    Observable<String>.of("1","2","3","4","5")
        .subscribe { event in //all event
            print(event)
        }
        .addDisposableTo(disposeBag)
     Observable<String>.of("5","4","3","2","1")
        .subscribe(onNext: { str in //only next event
            print(str)
        })
        .addDisposableTo(disposeBag)
}

/*
 example: from
 创建一个SequenceType类型元素的序列（例如：Array, Dictionary, Set）
 */
example("from:一个SequenceType元素的序列") {
    let disposeBag = DisposeBag()
    
    Observable.from(["1","2","3"])
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
}

/*
 example: create
 创建一个自定义的序列
 */
example("create:一个默认的序列") {
    let disposeBag = DisposeBag()
    
    //创建方式1
    Observable<String>.create { observerOfString in
        observerOfString.on(.next("😉"))
        observerOfString.on(.completed)
        return Disposables.create()
        }
        .subscribe(onNext: { event in
            print(event)
        })
        .addDisposableTo(disposeBag)
    
    //创建方式2
    let myJust = { (element: Int) -> Observable<Int> in
        return Observable.create { observerOfString in
            observerOfString.on(.next(element))
            observerOfString.on(.completed)
            return Disposables.create()
        }
    }
    
    myJust(99)
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
}

/*
 example: range
 创建一个可观察的序列，该序列释放一系列连续的整数，然后终止
 */
example("range:一个可观察的序列") {
    let disposeBag = DisposeBag()
    
    Observable.range(start: 1, count: 5)
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
}

/*
 example: repeatElement
 创建一个可观察的序列，无限地释放给定的元素
 */
example("repeatElement:一个可观察的序列，无限地释放给定的元素") {
    let disposeBag = DisposeBag()
    
    Observable.repeatElement("55")
        .take(3)
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
}

/*
 example: generate
 创建一个可观察的序列，只要提供的条件计算为true，则发出相应的事件。
 */
example("generate:一个可观察的序列，只要提供的条件计算为true，则发出相应的事件。") {
    let disposeBag = DisposeBag()
    
    Observable.generate(
            initialState: 0, //初始值
            condition: { $0 < 3 }, //条件语句
            iterate: { $0 + 1} //执行的操作
        )
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
}

/*
 example: deferred
 为每个订阅者创建一个新的可观察序列。
 */
example("deferred:为每个订阅者创建一个新的可观察序列") {
    let disposeBag = DisposeBag()
    var count = 1
    
    let deferredSequence = Observable<String>.deferred {
        print("Creating \(count)")
        count += 1
        
        return Observable.create { observer in
            observer.onNext("🐶")
            observer.onNext("🐱")
            observer.onNext("🐵")
            return Disposables.create()
        }
    }
    
    deferredSequence
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
    
    deferredSequence
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

/*
 example: error
 创建一个可观察的序列，该序列不发出任何正常的事件，只发出error事件并结束。
 */
example("error:一个可观察的序列，该序列不发出任何正常的事件，只发出error事件并结束。") {
    let disposeBag = DisposeBag()
    
    Observable<Int>.error(NSError(domain: "Test", code: -1, userInfo: nil))
        .subscribe { print($0) }
        .addDisposableTo(disposeBag)
}

/*
 example: doOn
 为每个已发出的事件前调用一个副作用动作，并发出（通过）原始事件。
 */
example("doOn:为每个已发出的事件调用一个副作用动作，并返回（通过）原始事件") {
    let disposeBag = DisposeBag()
    
    Observable.of("🍎", "🍐", "🍊", "🍋")
        .do(onNext: { print("Intercepted:", $0) }, onError: { print("Intercepted error:", $0) }, onCompleted: { print("Completed")  })
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

