//
//  CollectionListViewController.swift
//  Rijksmuseum-iOS
//
//  Created by Dragos-Costin Mandu on 9/15/22.
//

import UIKit

protocol CollectionListDisplayLogic: AnyObject {
    
    func displayCollectionList(with viewModel: CollectionListModels.GetCollectionList.ViewModel)
    func displayCollectionDetails()
    
}

class CollectionListViewController: UIViewController {
    
    // MARK: - Public Variables
    
    var interactor: CollectionListBusinessLogic?
    var router: (CollectionListRoutingLogic & CollectionListDataPassing)?
    
    // MARK: - Private Variables
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: .padding.large,
                                    left: 0,
                                    bottom: .padding.large,
                                    right: 0)
        
        return layout
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        
        collectionView.register(CollectionListCollectionViewCell.self,
                                forCellWithReuseIdentifier: CollectionListCollectionViewCell.id)
        collectionView.register(LabelCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: LabelCollectionReusableView.id)
        collectionView.register(LabelCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: LabelCollectionReusableView.id)
        
        return collectionView
    }()
    
    private let numberOfItemsInSection = 20
    
    private var viewModels: [CollectionListCollectionViewCell.ViewModel] = []
    private var footerViewModel: LabelCollectionReusableView.ViewModel?
    
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
        didPullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .black
    }
    
}

// MARK: - UICollectionViewDataSource

extension CollectionListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModels.count / numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionListCollectionViewCell.id,
                                                            for: indexPath) as? CollectionListCollectionViewCell,
              let viewModel = viewModels[safe: getViewModelIndex(for: indexPath)] else {
            return .init(frame: .zero)
        }
        
        cell.configure(with: viewModel)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return getHeaderView(with: kind, for: indexPath)
            
        case UICollectionView.elementKindSectionFooter:
            return getFooterView(with: kind, for: indexPath)
            
        default: return .init()
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension CollectionListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModels.count - getViewModelIndex(for: indexPath) + 1 < 3 {
            interactor?.getNextCollectionListPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = getViewModelIndex(for: indexPath)
        let request = CollectionListModels.SelectCollection.Request(index: index)
        
        interactor?.selectCollection(request: request)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width - 2 * CGFloat.padding.margin,
              height: CollectionListCollectionViewCell.preferredHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .padding.xxLarge
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: view.frame.width - 2 * CGFloat.padding.margin,
              height: LabelCollectionReusableView.preferredHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if footerViewModel != nil {
            return .init(width: view.frame.width - 2 * CGFloat.padding.margin,
                         height: LabelCollectionReusableView.preferredHeight)
        }
        
        return .zero
    }
    
}

// MARK: - CollectionListDisplayLogic

extension CollectionListViewController: CollectionListDisplayLogic {
    
    func displayCollectionList(with viewModel: CollectionListModels.GetCollectionList.ViewModel) {
        viewModels = viewModel.cellViewModels
        footerViewModel = viewModel.footerViewModel
        
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
    
    func displayCollectionDetails() {
        router?.routeToCollectionDetails()
    }
    
}

// MARK: - Setup

private extension CollectionListViewController {
    
    func linkComponents() {
        let viewController = self
        let interactor = CollectionListInteractor()
        let presenter = CollectionListPresenter()
        let router = CollectionListRouter()
        
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
        title = "Collections"
        
        view.addSubviews([collectionView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

// MARK: - Private Helpers

private extension CollectionListViewController {
    
    func getHeaderView(with kind: String, for indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: LabelCollectionReusableView.id,
                                                                               for: indexPath) as? LabelCollectionReusableView else {
            return .init()
        }
        
        headerView.configure(with: .init(text: "Page: \(indexPath.section + 1)",
                                         textColor: .systemGray,
                                         textAlignment: .left,
                                         font: .systemFont(ofSize: 14, weight: .semibold),
                                         bgColor: .clear))
        
        return headerView
    }
    
    func getFooterView(with kind: String, for indexPath: IndexPath) -> UICollectionReusableView {
        guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: LabelCollectionReusableView.id,
                                                                               for: indexPath) as? LabelCollectionReusableView else {
            return .init()
        }
        
        if let footerViewModel = footerViewModel {
            footerView.configure(with: footerViewModel)
        }
        
        return footerView
    }
    
    func getViewModelIndex(for indexPath: IndexPath) -> Int {
        indexPath.section * numberOfItemsInSection + indexPath.row
    }
    
}

// MARK: - Actions

private extension CollectionListViewController {
    
    @objc func didPullToRefresh() {
        collectionView.refreshControl?.beginRefreshing()
        interactor?.refreshCollectionList()
    }
    
}
