//
//  RxSwift+PropertyWrapper.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 13.01.25.
//

import Foundation
import RxSwift
import RxRelay

protocol RxPublisherObserver: ObservableType {
    init()
}

protocol RxValueObserver: ObservableType {
    init(value: Element)
}

extension BehaviorSubject: RxValueObserver {}
extension BehaviorRelay: RxValueObserver {}

extension PublishSubject: RxPublisherObserver {}
extension PublishRelay: RxPublisherObserver {}
