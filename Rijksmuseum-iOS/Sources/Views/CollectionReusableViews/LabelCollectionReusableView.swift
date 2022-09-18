//
//  LabelCollectionReusableView.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/18/22.
//

import UIKit

class LabelCollectionReusableView: UICollectionReusableView {
    
    struct ViewModel {
        let text: String
        let textColor: UIColor
        let textAlignment: NSTextAlignment
        let font: UIFont
        let bgColor: UIColor
    }
    
    // MARK: - Public Variables
    
    static let preferredHeight: CGFloat = 40
    
    // MARK: - Private Variables
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addCornerRadius(10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
    }
    
}

// MARK: - Public Helpers

extension LabelCollectionReusableView {
    
    func configure(with viewModel: ViewModel) {
        label.text = viewModel.text
        label.textColor = viewModel.textColor
        label.textAlignment = viewModel.textAlignment
        label.font = viewModel.font
        
        backgroundColor = viewModel.bgColor
    }
    
}

// MARK: - Setup

private extension LabelCollectionReusableView {
    
    func setup() {
        addSubview(label)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.small),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding.small),
            label.topAnchor.constraint(equalTo: topAnchor, constant: .padding.small),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding.small),
        ])
    }
    
}
