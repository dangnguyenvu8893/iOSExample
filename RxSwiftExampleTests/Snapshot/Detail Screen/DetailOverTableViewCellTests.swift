//
//  DetailOverTableViewCellTests.swift
//  RxSwiftExampleTests
//
//  Created by Vu Dang on 10/24/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import RxSwift
import RxCocoa
@testable import RxSwiftExample

class DetailOverTableViewCellTests: FBSnapshotTestCase {

    var table: XTableView!
    
    override func setUp() {
        super.setUp()
        self.recordMode = true
        let movie = Movie()
        let controller = Screens.detail(movie: movie).controller()
        table = (controller.view.subviews.first(where: {$0.className == XTableView.className}) as! XTableView)
    }
    
    func testOverviewShort() {
        let container = TableViewCellSnapshotContainer<DetailOveriewTableViewCell>(width: 375, configureCell: { cell in
            var movie = Movie()
            movie.overview = """
            Too Short
            """
            cell.bind(movie: movie)
        }, tableBackgroundColor:  table.backgroundColor)
        
        FBSnapshotVerifyView(container)
    }
    
    func testOverviewNormal() {
        let container = TableViewCellSnapshotContainer<DetailOveriewTableViewCell>(width: 375, configureCell: { cell in
            var movie = Movie()
            movie.overview = """
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            Too Normal
            """
            cell.bind(movie: movie)
        }, tableBackgroundColor:  table.backgroundColor)

        FBSnapshotVerifyView(container)
    }
    
    func testOverviewLong() {
        let container = TableViewCellSnapshotContainer<DetailOveriewTableViewCell>(width: 375, configureCell: { cell in
            var movie = Movie()
            movie.overview = """
            1
            2
            3
            4
            5
            6
            7
            8
            9
            10
            11
            12
            13
            14
            15
            16
            17
            18
            19
            20
            21
            22
            23
            24
            25
            26
            27
            28
            29
            30
            31
            32
            33
            34
            35
            36
            37
            38
            39
            40
            41
            42
            43
            44
            45
            46
            47
            48
            49
            50
            1
            2
            3
            4
            5
            6
            7
            8
            9
            10
            11
            12
            13
            14
            15
            16
            17
            18
            19
            20
            21
            22
            23
            24
            25
            26
            27
            28
            29
            30
            31
            32
            33
            34
            35
            36
            37
            38
            39
            40
            41
            42
            43
            44
            45
            46
            47
            48
            49
            50
            """
            cell.bind(movie: movie)
        }, tableBackgroundColor:  table.backgroundColor)
        
        FBSnapshotVerifyView(container)
    }
}
