//
//  MovieCollectionViewCell.swift
//  RxSwiftExampleTests
//
//  Created by Vu Dang on 10/23/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import RxSwift
import RxCocoa
@testable import RxSwiftExample

class MovieCollectionViewTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }
    
    func testFullCollectionView() {
        let mock = HomeScreenMockData()
        let viewModel = HomeViewModel(realmUseCase: mock,
                                      apiUseCase: mock,
                                      navigatorUseCase: mock)
        let controller = HomeViewController.createWith(viewModel)
        mock.mockDataFromAPI = { page in
            var response = Response<Movie>()
            response.results = mock.defaultMovie
            response.page = page
            response.totalPages = 13

            return Observable.just(response)
        }
        mock.mockDataFromRealm = {
            return mock.defaultMovie
        }

        FBSnapshotVerifyView(controller.view)
    }
    
    func testEmptyCollectionView() {
        let mock = HomeScreenMockData()
        let viewModel = HomeViewModel(realmUseCase: mock,
                                      apiUseCase: mock,
                                      navigatorUseCase: mock)
        let controller = HomeViewController.createWith(viewModel)

        mock.mockDataFromAPI = { page in
            var response = Response<Movie>()
            response.results = []
            response.page = 0
            response.totalPages = 0
            return Observable.just(response)
        }
        
        mock.mockDataFromRealm = {
            return mock.defaultMovie
        }

        FBSnapshotVerifyView(controller.view)
    }
}
