//
//  CategoryRouter.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 14.01.25.
//

import UIKit

final class CategoryRouter: CategoryRouterProtocol {
    weak var root: UIViewController?
    
    func show(product: Product) {
        let vc = ProductPreviewAssembler.make(product: product)
        root?.navigationController?.pushViewController(vc, animated: true)
    }

}
