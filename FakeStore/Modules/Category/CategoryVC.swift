//
//  CategoryVC.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 14.01.25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol CategoryViewModel {
    var products: BehaviorSubject<[Product]> { get }
}

final class CategoryVC: UIViewController {
    private let viewModel: CategoryViewModel
    private let bag = DisposeBag()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.register(SingleCategoryCell.self, forCellWithReuseIdentifier: "\(SingleCategoryCell.self)")
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
    }
    
    init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        viewModel.products.bind(to: collection.rx.items(cellIdentifier: "\(SingleCategoryCell.self)", cellType: SingleCategoryCell.self)) { row, element, cell in
            cell.config(with: element)
        }
        .disposed(by: bag)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collection)
        collection.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}


extension CategoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        let space: CGFloat = flowLayout.minimumInteritemSpacing + flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let size: CGFloat = (collection.frame.size.width - space) / 2
        return CGSize(width: size, height: size)
    }
}
