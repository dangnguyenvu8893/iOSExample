//
//  DetailViewController.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: XViewController, ViewModelViewController {

    var viewModel: DetailViewModel!

    @IBOutlet private weak var tableView: XTableView!
    
    private var cacheHeight = [IndexPath: CGFloat]()
    
    override func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerCell(DetailPosterTableViewCell.self)
        tableView.registerCell(DetailOveriewTableViewCell.self)
        tableView.registerCell(DetailPersonTableViewCell.self)
        tableView.registerHeaderFooter(DetailHeaderView.self)
    }
    
    override func bindViewModel() {
        let viewDidLoad = Driver.just(())
        let input = ViewModel.Input(viewDidLoad: viewDidLoad)
        let output = viewModel.transform(input, with: bag)
        
        output.reload.drive(onNext: { [unowned self] movie in
            self.tableView.reloadData()
            self.title = movie.originalTitle
        }).disposed(by: bag)
        output.loading.drive(rx.isLoading).disposed(by: bag)
    }
}

extension DetailViewController {

    enum SectionType: Int, CaseIterable {
        case poster
        case overview
        case director
        case cast
        
        var sectionTitle: String {
            switch self {
            case .overview:
                return "Overview"
            case .director:
                return "Director"
            case .cast:
                return "Cast"
            default:
                return ""
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else {
            return 0
        }
        switch sectionType {
        case .poster:
            return 1
        case .overview:
            return 1
        case .director:
            return 1
        case .cast:
            return viewModel.numberOfCast()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch sectionType {
        case .poster:
            let cell = tableView.dequeueCell(DetailPosterTableViewCell.self)
            cell.bind(viewModel.movie)
            return cell
        case .overview:
            let cell = tableView.dequeueCell(DetailOveriewTableViewCell.self)
            cell.bind(movie: viewModel.movie)
            return cell
        case .director:
            let cell = tableView.dequeueCell(DetailPersonTableViewCell.self)
            cell.bind(person: viewModel.director, isDirection: true)
            return cell
        case .cast:
            let cell = tableView.dequeueCell(DetailPersonTableViewCell.self)
            cell.bind(person: viewModel.cast(at: indexPath.row), isDirection: false)
            return cell
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionType = SectionType(rawValue: section) else {
            return nil
        }
        switch sectionType {
        case .director, .cast, .overview:
            let header = tableView.dequeueHeaderFooter(DetailHeaderView.self)
            header.bind(name: sectionType.sectionTitle)
            return header
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionType = SectionType(rawValue: section) else {
            return 0.0
        }
        switch sectionType {
        case .director, .cast, .overview:
            return DetailHeaderView.defaultHeight()
        default:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cachedHeight = cacheHeight[indexPath] {
            return cachedHeight
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sectionType = SectionType(rawValue: indexPath.section) else {
            return UITableView.automaticDimension
        }
        switch sectionType {
        case .poster:
            return DetailPosterTableViewCell.defaultHeight()
        case .overview:
            return DetailOveriewTableViewCell.defaultHeight()
        case .director, .cast:
            return DetailPersonTableViewCell.defaultHeight()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cacheHeight[indexPath] = cell.frame.size.height
    }
}
