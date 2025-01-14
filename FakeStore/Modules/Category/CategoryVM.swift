//
//  CategoryVM.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 14.01.25.
//

import Foundation
import RxSwift


protocol CategoryRouterProtocol {
    
}

final class CategoryVM: CategoryViewModel {
    private let router: CategoryRouterProtocol
    
    var products: BehaviorSubject<[Product]>
    
    init(router: CategoryRouterProtocol, products: [Product]) {
        self.router = router
        self.products = BehaviorSubject(value: products)
    }
    
}
