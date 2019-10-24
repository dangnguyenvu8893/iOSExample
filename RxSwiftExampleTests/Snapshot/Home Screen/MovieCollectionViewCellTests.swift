//
//  MovieCollectionViewCellTests.swift
//  RxSwiftExampleTests
//
//  Created by Vu Dang on 10/24/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import XCTest
import FBSnapshotTestCase
import RxSwift
import RxCocoa
import UIKit
@testable import RxSwiftExample

class MovieCollectionViewCellTests: FBSnapshotTestCase {
    
    var homeController: HomeViewController!
    let mock = HomeScreenMockData()
    
    override func setUp() {
        super.setUp()
        let viewModel = HomeViewModel(realmUseCase: mock,
                                      apiUseCase: mock,
                                      navigatorUseCase: mock)
        let controller = HomeViewController.createWith(viewModel)
        mock.mockDataFromAPI = { page in
            var response = Response<Movie>()
            response.results = self.mock.defaultMovie
            response.page = page
            response.totalPages = 13
            
            return Observable.just(response)
        }
        mock.mockDataFromRealm = {
            return self.mock.defaultMovie
        }
        homeController = controller
        self.recordMode = false
    }

    func testImageLoader() {
        let collectionView = homeController.view.subviews.first(where: {$0.className == "XCollectionView"}) as! XCollectionView
        let cell = collectionView.dequeueCell(MovieCollectionViewCell.self, indexPath: IndexPath(item: 0, section: 0))
        cell.configure(mock.defaultMovie.first!)
        FBSnapshotVerifyView(cell)
    }
    
    func testNilObjectLoader() {
        let collectionView = homeController.view.subviews.first(where: {$0.className == "XCollectionView"}) as! XCollectionView
        let cell = collectionView.dequeueCell(MovieCollectionViewCell.self, indexPath: IndexPath(item: 0, section: 0))
        let movie = Movie()
        cell.configure(movie)
        FBSnapshotVerifyView(cell)
    }
}
