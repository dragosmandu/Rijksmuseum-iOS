//
//  CollectionListCollectionViewCell.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import Kingfisher
import UIKit

class CollectionListCollectionViewCell: UICollectionViewCell {
    
    class ViewModel: Hashable, Equatable {
        let id: String
        let titleText: String
        let subtitleText: String?
        let imageUrl: URL?
        
        init(id: String, titleText: String, subtitleText: String?, imageUrl: URL?) {
            self.id = id
            self.titleText = titleText
            self.subtitleText = subtitleText
            self.imageUrl = imageUrl
        }
        
        static func ==(lhs: ViewModel, rhs: ViewModel) -> Bool {
            lhs.id == rhs.id &&
            lhs.titleText == rhs.titleText &&
            lhs.subtitleText == rhs.subtitleText &&
            lhs.imageUrl == rhs.imageUrl
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    // MARK: - Public Variables
    
    static let preferredHeight: CGFloat = 60
    
    // MARK: - Private Variables
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var imageOptions: KingfisherOptionsInfo = {
        let size = CGSize(width: Self.preferredHeight, height: Self.preferredHeight)
        
        return [.processor(DownsamplingImageProcessor(size: size)),
                .diskCacheExpiration(.seconds(imageDiskCacheExpSec)),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3))]
    }()
    
    private let imagePlaceholder = UIImage(named: "imagePlaceholder")
    private let imageDiskCacheExpSec: TimeInterval = 60 * 30
    
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
        
        imageView.addCornerRadius(16)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        
        imageView.kf.cancelDownloadTask()
    }
    
}

// MARK: - Public Helpers

extension CollectionListCollectionViewCell {
    
    func configure(with viewModel: ViewModel) {
        titleLabel.text = viewModel.titleText
        subtitleLabel.text = viewModel.subtitleText
        
        imageView.kf.setImage(with: viewModel.imageUrl,
                              placeholder: imagePlaceholder,
                              options: imageOptions)
    }
    
}

// MARK: - Setup

private extension CollectionListCollectionViewCell {
    
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.addSubviews([imageView, titleLabel, subtitleLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Self.preferredHeight),
            imageView.widthAnchor.constraint(equalToConstant: Self.preferredHeight)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: .padding.medium),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: .padding.medium),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
    }
    
}
