//
//  CategoriesVC.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 11.01.25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol CategoriesViewModelProtocol {
    //in
    var categorySelected: PublishSubject<String> { get }
    //out
    var categories: Observable<[String]> { get }
}

final class CategoriesVC: UIViewController {
    
    private let bag = DisposeBag()
    //    private let networkService = NetworkService()
    //    private let categories: BehaviorSubject<[String]> = .init(value: [])
    private let viewModel: CategoriesViewModelProtocol
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "\(CategoryCell.self)")
        return tableView
    }()
    
    init(viewModel: CategoriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categories"
        bind()
        setupUI()
    }
    
    private func bind() {
        viewModel.categories
            .bind(to:
                    tableView.rx.items(
                        cellIdentifier: "\(CategoryCell.self)",
                        cellType: CategoryCell.self
                    )) { row, element, cell in
                            cell.config(with: element)
                        }
                        .disposed(by: bag)
        
        tableView.rx.itemSelected
            .withLatestFrom(viewModel.categories, resultSelector: { $1[$0.row] })
            .bind(to: viewModel.categorySelected)
            .disposed(by: bag)
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
