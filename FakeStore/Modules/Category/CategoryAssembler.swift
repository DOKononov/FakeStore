//
//  CategoryAssembler.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 14.01.25.
//

import UIKit

final class CategoryAssembler {
    private init() {}
    
    static func make(products: [Product]) -> UIViewController {
        let router = CategoryRouter()
        let vm = CategoryVM(router: router, products: products)
        let vc = CategoryVC(viewModel: vm)
        router.root = vc
        return vc
    }
}

