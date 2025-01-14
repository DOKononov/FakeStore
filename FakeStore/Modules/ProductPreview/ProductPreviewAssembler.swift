//
//  ProductPreviewAssembler.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 14.01.25.
//

import UIKit

final class ProductPreviewAssembler {
    private init() {}
    
    static func make(product: Product) -> UIViewController {
        let router = ProductPreviewRouter()
        let vm = ProductPreviewVM(product: product, router: router)
        let vc = ProductPreviewVC(viewModel: vm)
        router.root = vc
        return vc
    }
}
