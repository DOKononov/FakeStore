//
//  CategoriesAssembler.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 13.01.25.
//

import UIKit

final class CategoriesAssembler {
    private init() {}
    
    static func make() -> UIViewController {
        let router = CategoriesRouter()
        let networkService = NetworkService()
        let vm = CategoriesVM(networkService: networkService, router: router)
        let vc = CategoriesVC(viewModel: vm)
        router.root = vc
        return vc
    }
}
