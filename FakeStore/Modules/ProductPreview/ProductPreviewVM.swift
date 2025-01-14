//
//  ProductPreviewVM.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 14.01.25.
//

import UIKit
import RxSwift

protocol ProductPreviewRouterProtocol {
    
}

final class ProductPreviewVM: ProductPreviewViewModel {
    var product: Product
    private let router: ProductPreviewRouterProtocol
    private let networkService = NetworkService()
    private let bag = DisposeBag()
    var imageDidSet: ((UIImage?) -> Void)?
    
    init(product: Product,
         router: ProductPreviewRouterProtocol
    ) {
        self.product = product
        self.router = router
        networkService.loadImage(from: product.image)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] image in
                self?.imageDidSet?(image)
            }
            .disposed(by: bag)
    }
}
