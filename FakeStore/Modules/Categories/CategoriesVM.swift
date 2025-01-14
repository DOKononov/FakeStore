//
//  CategoriesVM.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 11.01.25.
//

import Foundation
import RxSwift

protocol CategoriesRouterProtocol {
    func open(category: String, products: [Product])
}

final class CategoriesVM: CategoriesViewModelProtocol {
    private let bag = DisposeBag()
    private let networkService: NetworkService
    private let router: CategoriesRouterProtocol
    
    //in
    var categorySelected: PublishSubject<String> = .init()
    //out
    @Relay(value: [])
    var categories: Observable<[String]>

//    @OutputProperty(value: [], type: BehaviorSubject.self)
//    var categories: Observable<[String]>
    
//    private var _categories: BehaviorSubject<[String]> = .init(value: [])
//    var categories: Observable<[String]> { return _categories.asObserver() }
    
    init(networkService: NetworkService,
         router: CategoriesRouterProtocol) {
        self.networkService = networkService
        self.router = router
        bind()
    }
 
    private func bind() {
        networkService
            .loadCategories()
            .subscribe(on: MainScheduler.asyncInstance)
            .catchAndReturn([])
            .bind(to: _categories.rx)
            .disposed(by: bag)
        
        categorySelected
            .flatMapLatest { [weak self] category -> Observable<(category: String, products: [Product])> in
                guard let self else { return .empty() }
                return self.networkService.load(category: category)
                    .map { (category, $0) }
            }
            .subscribe(onNext: { [weak self] result in
                guard let self else { return }
                self.router.open(category: result.category, products: result.products)
            })
            .disposed(by: bag)
    }
}
