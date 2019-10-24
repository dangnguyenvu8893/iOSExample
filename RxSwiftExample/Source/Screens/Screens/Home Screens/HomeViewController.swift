//
//  HomeViewController.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: XViewController, ViewModelViewController {
    
    var viewModel: HomeViewModel!
    
    @IBOutlet private weak var collectionView: XCollectionView!
    @IBOutlet private weak var emptyLabel: UILabel!
    
    override func setupUI() {
        configureCollectionView()
    }
    
    override func bindViewModel() {
        let viewDidLoadTrigger = Driver.just(())
        let tableDidRefreshTrigger = collectionView.rx.refreshTrigger
        let tableDidLoadmoreTrigger = collectionView.rx.loadMoreTrigger
        let tableDidTapAtIndexTrigger = collectionView.rx.itemSelected.asDriver().map({$0.row})
        
        let input = HomeViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger,
                                        tableDidRefresh: tableDidRefreshTrigger,
                                        tableDidLoadmore: tableDidLoadmoreTrigger,
                                        didTapCellAtIndex: tableDidTapAtIndexTrigger)
        let output = viewModel.transform(input, with: bag)

        output.reload.drive(onNext: { [unowned self] data in
            self.setShowEmptyLabel(isShow: data.count == 0)
            self.collectionView.reloadData()
        }).disposed(by: bag)
        
        output.error.drive(onNext: { error in
            print(error.localizedDescription)
        }).disposed(by: bag)

        output.loading.drive(rx.isLoading).disposed(by: bag)
    }

    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(MovieCollectionViewCell.self)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2.0
        layout.minimumLineSpacing = 2.0
        let width = ((UIScreen.main.bounds.width - 4) / 3 )
        let height = width * MovieCollectionViewCell.ratio
        layout.itemSize = CGSize(width: width, height: height)
        collectionView.collectionViewLayout = layout
    }

    private func setShowEmptyLabel(isShow: Bool) {
        collectionView.isHidden = isShow
        emptyLabel.isHidden = !isShow
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(MovieCollectionViewCell.self, indexPath: indexPath)
        let movie = viewModel.itemAt(indexPath.row)
        cell.configure(movie)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
}
