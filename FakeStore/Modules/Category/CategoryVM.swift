//
//  CategoryVM.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 14.01.25.
//

import Foundation
import RxSwift


protocol CategoryRouterProtocol {
    func show(product: Product)
}

final class CategoryVM: CategoryViewModel {
    private let router: CategoryRouterProtocol
    private let bag = DisposeBag()
    
    var products: BehaviorSubject<[Product]>
    var selectedProduct: RxSwift.PublishSubject<Product> = .init()

    init(router: CategoryRouterProtocol, products: [Product]) {
        self.router = router
        self.products = BehaviorSubject(value: products)
        bind()
    }
    
    private func bind() {
        selectedProduct
            .subscribe { [weak self] product in
                self?.router.show(product: product)
            }
            .disposed(by: bag)
    }
}
