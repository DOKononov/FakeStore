//
//  SingleCategoryCell.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 14.01.25.
//

import UIKit
import SnapKit
import RxSwift

final class SingleCategoryCell: UICollectionViewCell {
    private let networkService = NetworkService()
    let bag = DisposeBag()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .thin)
        label.textColor = .systemBlue
        label.textAlignment = .right
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with product: Product) {
        networkService.loadImage(from: product.image)
            .bind(to: imageView.rx.image)
            .disposed(by: bag)
        priceLabel.text = "\(product.price)"
        titleLabel.text = product.title
    }
    
    private func setupUI() {
        clipsToBounds = true
        contentView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        contentView.layer.borderWidth = 1
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(contentView.snp.height).multipliedBy(0.6)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.trailing.bottom.equalToSuperview().inset(8)
        }
    }
}
