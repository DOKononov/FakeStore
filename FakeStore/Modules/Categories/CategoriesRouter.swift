//
//  CategoriesRouter.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 13.01.25.
//

import UIKit

final class CategoriesRouter: CategoriesRouterProtocol {

    weak var root: UIViewController?
    
    func open(category: String) {
        let vc = UIViewController()
        vc.title = category
        vc.view.backgroundColor = .systemBackground
        root?.navigationController?.pushViewController(vc, animated: true)
    }
}
