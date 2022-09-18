//
//  CollectionDetailsDetailsView.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/18/22.
//

import UIKit

class CollectionDetailsDetailsScrollView: UIScrollView {
    
    struct ViewModel {
        let id: String?
        let productionPlaces: [String]
        let acquisitionDateStr: String?
        let prirefStr: String?
        let description: String?
        let err: CollectionDetailsModels.Error?
    }
    
    // MARK: - Public Variables
    
    var onPullToRefresh: (() -> Void)?
    
    // MARK: - Private Variables
    
    private lazy var idLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var acquisitionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var prirefLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var productionPlacesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var errLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .red
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private var contentHeight: CGFloat {
        idLabel.frame.height +
        prirefLabel.frame.height +
        productionPlacesLabel.frame.height +
        descLabel.frame.height +
        CGFloat.padding.margin * 2 +
        CGFloat.padding.small +
        CGFloat.padding.medium
    }
    
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
        
        contentInset = .init(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0)
        contentSize = .init(width: frame.width, height: contentHeight)
    }
    
}

// MARK: - Public Helpers

extension CollectionDetailsDetailsScrollView {
    
    func configure(with viewModel: ViewModel) {
        refreshControl?.endRefreshing()
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            guard let err = viewModel.err else {
                self?.idLabel.text = viewModel.id
                self?.acquisitionLabel.text = viewModel.acquisitionDateStr
                self?.prirefLabel.text = viewModel.prirefStr
                self?.descLabel.text = viewModel.description
                
                self?.updateProductionPlaces(viewModel.productionPlaces)
                
                return
            }
            
            self?.errLabel.text = err.localizedDescription
        }
    }
    
}

// MARK: - Setup

private extension CollectionDetailsDetailsScrollView {

    func setup() {
        addSubviews([idLabel, acquisitionLabel, prirefLabel, productionPlacesLabel, descLabel, errLabel])
        setupConstraints()
        setupRefreshControl()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.margin),
            idLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            idLabel.topAnchor.constraint(equalTo: topAnchor, constant: .padding.margin),
        ])
        
        NSLayoutConstraint.activate([
            acquisitionLabel.leadingAnchor.constraint(equalTo: centerXAnchor),
            acquisitionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding.margin),
            acquisitionLabel.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            prirefLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.margin),
            prirefLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding.margin),
            prirefLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: .padding.small),
        ])
        
        NSLayoutConstraint.activate([
            productionPlacesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.margin),
            productionPlacesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding.margin),
            productionPlacesLabel.topAnchor.constraint(equalTo: prirefLabel.bottomAnchor, constant: .padding.medium),
        ])
        
        NSLayoutConstraint.activate([
            descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.margin),
            descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding.margin),
            descLabel.topAnchor.constraint(equalTo: productionPlacesLabel.bottomAnchor, constant: .padding.margin),
        ])
        
        NSLayoutConstraint.activate([
            errLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.margin),
            errLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding.margin),
            errLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func setupRefreshControl() {
        refreshControl = .init(frame: .zero)
        refreshControl?.transform = .init(scaleX: 0.7, y: 0.7)
        
        refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        refreshControl?.beginRefreshing()
    }
    
}

// MARK: - Private Helpers

private extension CollectionDetailsDetailsScrollView {
    
    func updateProductionPlaces(_ productionPlaces: [String]) {
        if productionPlaces.count > 0 {
            productionPlacesLabel.text = "Production Places: \(productionPlaces.joined(separator: ", "))"
        } else {
            productionPlacesLabel.text = "Production Places: Unknown"
        }
    }
    
}

// MARK: - Actions

private extension CollectionDetailsDetailsScrollView {
    
    @objc func didPullToRefresh() {
        onPullToRefresh?()
    }
    
}
