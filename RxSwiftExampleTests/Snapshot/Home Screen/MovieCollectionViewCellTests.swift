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

class MovieCollectionViewCellTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }
    
    func testFullCollectionView() {
        let mock = HomeScreenMockData()
        let viewModel = HomeViewModel(realmUseCase: mock, apiUseCase: mock)
        let controller = HomeViewController.createWith(viewModel)
        mock.mockUpCommingMovie = {
            var response = Response<Movie>()
            response.results = mock.defaultMovie
            response.page = 1
            response.totalPages = 13

            return response
        }
        FBSnapshotVerifyView(controller.view)
    }
    
    func testEmptyCollectionView() {
        let mock = HomeScreenMockData()
        let viewModel = HomeViewModel(realmUseCase: mock, movieAPIUseCase: mock)
        let controller = HomeViewController.createWith(viewModel)
        mock.mockUpCommingMovie = {
            var response = Response<Movie>()
            response.results = []
            response.page = 0
            response.totalPages = 0
            return response
        }
        FBSnapshotVerifyView(controller.view)
    }
}
