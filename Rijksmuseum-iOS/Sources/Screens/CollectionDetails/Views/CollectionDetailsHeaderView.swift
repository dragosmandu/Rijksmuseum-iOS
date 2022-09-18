//
//  CollectionDetailsHeaderView.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/18/22.
//

import Kingfisher
import UIKit

class CollectionDetailsHeaderView: UIView {
    
    struct ViewModel {
        let imageUrl: URL?
        let principalOrFirstMaker: String?
        let longTitle: String?
    }
    
    // MARK: - Private Variables
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = imagePlaceholder
        
        return imageView
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: effect)
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return blurEffectView
    }()
    
    private lazy var principalOrFirstMakerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var longTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var imageOptions: KingfisherOptionsInfo = {
        return [.diskCacheExpiration(.seconds(imageDiskCacheExpSec)),
                .transition(.fade(0.4))]
    }()
    
    private let imagePlaceholder = UIImage(named: "imagePlaceholder")
    private let imageDiskCacheExpSec: TimeInterval = 60 * 30
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addCornerRadius(18, maskedCorners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
    }
    
}

// MARK: - Public Helpers

extension CollectionDetailsHeaderView {
    
    func configure(with viewModel: ViewModel) {
        principalOrFirstMakerLabel.text = viewModel.principalOrFirstMaker
        longTitleLabel.text = viewModel.longTitle
        
        imageView.kf.setImage(with: viewModel.imageUrl,
                              placeholder: imagePlaceholder,
                              options: imageOptions)
    }
    
}

// MARK: - Setup

private extension CollectionDetailsHeaderView {
    
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(imageView)
        imageView.addSubview(blurEffectView)
        blurEffectView.contentView.addSubviews([principalOrFirstMakerLabel,
                                               longTitleLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.topAnchor.constraint(greaterThanOrEqualTo: imageView.centerYAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            longTitleLabel.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: .padding.margin),
            longTitleLabel.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -.padding.margin),
            longTitleLabel.bottomAnchor.constraint(equalTo: blurEffectView.bottomAnchor, constant: -.padding.margin)
        ])
        
        NSLayoutConstraint.activate([
            principalOrFirstMakerLabel.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: .padding.margin),
            principalOrFirstMakerLabel.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -.padding.margin),
            principalOrFirstMakerLabel.topAnchor.constraint(equalTo: blurEffectView.topAnchor, constant: .padding.margin),
            principalOrFirstMakerLabel.bottomAnchor.constraint(equalTo: longTitleLabel.topAnchor, constant: -.padding.medium),
        ])
    }
    
}
