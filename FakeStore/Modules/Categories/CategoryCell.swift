//
//  CategoryCell.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 11.01.25.
//

import UIKit
import SnapKit

final class CategoryCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    func config(with category: String) {
        self.titleLabel.text = category
    }
}
