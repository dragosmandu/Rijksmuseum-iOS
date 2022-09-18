//
//  CollectionDetailsViewController.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import UIKit

protocol CollectionDetailsDisplayLogic: AnyObject {
    
    func displayCollectionDetails(with viewModel: CollectionDetailsModels.GetCollectionDetails.ViewModel)
    
}

class CollectionDetailsViewController: UIViewController {
    
    // MARK: - Public Variables
    
    var interactor: CollectionDetailsBusinessLogic?
    var router: (CollectionDetailsRoutingLogic & CollectionDetailsDataPassing)?
    
    // MARK: - Private Variables
    
    private lazy var headerView: CollectionDetailsHeaderView = {
        let view = CollectionDetailsHeaderView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var detailsView: CollectionDetailsDetailsScrollView = {
        let scrollView = CollectionDetailsDetailsScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.onPullToRefresh = { [weak self] in
            self?.getData()
        }
        
        return scrollView
    }()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        linkComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        linkComponents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barStyle = .black
    }
    
}

// MARK: - CollectionDetailsDisplayLogic

extension CollectionDetailsViewController: CollectionDetailsDisplayLogic {
    
    func displayCollectionDetails(with viewModel: CollectionDetailsModels.GetCollectionDetails.ViewModel) {
        headerView.configure(with: viewModel.headerViewModel)
        detailsView.configure(with: viewModel.detailsViewModel)
    }
    
}

// MARK: - Setup

private extension CollectionDetailsViewController {
    
    func linkComponents() {
        let viewController = self
        let interactor = CollectionDetailsInteractor()
        let presenter = CollectionDetailsPresenter()
        let router = CollectionDetailsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setup() {
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        
        view.addSubviews([headerView, detailsView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: .padding.margin),
            detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func getData() {
        interactor?.getCollectionDetails()
    }
    
}

// MARK: - Private Helpers

private extension CollectionDetailsViewController {
    
}
