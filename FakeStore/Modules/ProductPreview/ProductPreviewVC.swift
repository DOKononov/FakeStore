//
//  ProductPreviewVC.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 14.01.25.
//

import UIKit
import SnapKit

protocol ProductPreviewViewModel {
    var product: Product { get }
    var imageDidSet: ((UIImage?) -> Void)? { get set }
}

final class ProductPreviewVC: UIViewController {
    private var viewModel: ProductPreviewViewModel
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.product.title
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.product.description
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ \(viewModel.product.price)"
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.setTitle("Buy", for: .normal)
        return button
    }()
    
    init(viewModel: ProductPreviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func bind() {
        viewModel.imageDidSet = { [weak self] image in
            self?.imageView.image = image
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(priceLabel)
        view.addSubview(buyButton)
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(imageView.snp.width)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(buyButton)
        }
        
        buyButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.equalTo(priceLabel.snp.trailing).offset(16)
            make.width.equalTo(150)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
}
