//
//  HomeViewModelTests.swift
//  RxSwiftExampleTests
//
//  Created by Vu Dang on 10/24/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import RxSwiftExample

class HomeViewModelTests: XCTestCase {

    var bag = DisposeBag()
    override func setUp() {
        bag = DisposeBag()
    }

    func testMainFlow() {
        let mockObj = HomeScreenMockData()
        mockObj.mockDataFromAPI = { page in
            var response = Response<Movie>()
            response.results = mockObj.defaultMovie
            response.page = page
            response.totalPages = 13

            return Observable.just(response)
        }
        mockObj.mockDataFromRealm = {
            return mockObj.defaultMovie
        }
        
        let viewDidLoad = Driver.just(())
        let tableViewReload = PublishSubject<Void>()
        let tableViewLoadmore = PublishSubject<Void>()
        let tableViewDidTapIndex = PublishSubject<Int>()
        let viewModel = HomeViewModel(realmUseCase: mockObj,
                                  apiUseCase: mockObj,
                                  navigatorUseCase: mockObj)
        let input = HomeViewModel.Input(viewDidLoadTrigger: viewDidLoad,
                                        tableDidRefresh: tableViewReload.asDriverOnErrorJustComplete(),
                                        tableDidLoadmore: tableViewLoadmore.asDriverOnErrorJustComplete(),
                                        didTapCellAtIndex: tableViewDidTapIndex.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input, with: bag)
        
        output.reload.take(1).drive(onNext: { movies in
            XCTAssert(movies.count == 4)
            XCTAssert(mockObj.isCallSaveMovieToRealm)
            XCTAssert(mockObj.lastestLoaderPage == 1)
        }).disposed(by: bag)
    }
    
    func testLoadMoreFlow() {
        let mockObj = HomeScreenMockData()
        mockObj.mockDataFromAPI = { page in
            var response = Response<Movie>()
            response.results = mockObj.defaultMovie
            response.page = page
            response.totalPages = 13
            
            return Observable.just(response)
        }
        mockObj.mockDataFromRealm = {
            return mockObj.defaultMovie
        }
        
        let viewDidLoad = Driver.just(())
        let tableViewReload = PublishSubject<Void>()
        let tableViewLoadmore = PublishSubject<Void>()
        let tableViewDidTapIndex = PublishSubject<Int>()
        let viewModel = HomeViewModel(realmUseCase: mockObj,
                                      apiUseCase: mockObj,
                                      navigatorUseCase: mockObj)
        let input = HomeViewModel.Input(viewDidLoadTrigger: viewDidLoad,
                                        tableDidRefresh: tableViewReload.asDriverOnErrorJustComplete(),
                                        tableDidLoadmore: tableViewLoadmore.asDriverOnErrorJustComplete(),
                                        didTapCellAtIndex: tableViewDidTapIndex.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input, with: bag)
        
        let expectation = self.expectation(description: #function)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            tableViewLoadmore.onNext(())
        }
        
        output.reload.debounce(3.0).drive(onNext: { movies in
            XCTAssert(movies.count == 4)
            XCTAssert(mockObj.isCallSaveMovieToRealm)
            XCTAssert(mockObj.lastestLoaderPage == 2)
            expectation.fulfill()
        }).disposed(by: bag)
        
        waitForExpectations(timeout: 10)
    }
}
