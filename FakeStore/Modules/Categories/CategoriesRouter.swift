//
//  CategoriesRouter.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 13.01.25.
//

import UIKit

final class CategoriesRouter: CategoriesRouterProtocol {

    weak var root: UIViewController?
    
    func open(category: String, products: [Product]) {
        let vc = CategoryAssembler.make(products: products)
        vc.title = category
        root?.navigationController?.pushViewController(vc, animated: true)
    }
}
