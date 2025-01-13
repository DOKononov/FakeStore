//
//  OutputProperty.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 12.01.25.
//

import RxSwift

@propertyWrapper
class OutputProperty<Event, RxObserver: ObservableConvertibleType> where Event == RxObserver.Element {
    let rx: RxObserver
    
    var wrappedValue: Observable<Event> {
        return rx.asObservable()
    }
    
    init(value: RxObserver.Element, type: RxObserver.Type) where RxObserver: RxValueObserver {
        rx = type.init(value: value)
    }
    
    init(type: RxObserver.Type) where RxObserver: RxPublisherObserver {
        rx = type.init()
    }
}


