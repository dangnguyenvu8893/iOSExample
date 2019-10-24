//
//  Navigator.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import UIKit

enum Screens {
    
    case home
    case detail(movie: Movie)
    
    func controller() -> UIViewController {
        switch self {
        case .home:
            let viewModel = HomeViewModel()
            return HomeViewController.createWith(viewModel)
        case .detail(let movie):
            let viewModel = DetailViewModel(movie: movie)
            return DetailViewController.createWith(viewModel)
        }
    }
}

class Navigator {
    
    static var shared: Navigator!
    
    private weak var container: UIViewController?

    init(container: UIViewController) {
        self.container = container
    }

    func setRoot(_ segue: Screens) {
        guard let navigation = container as? UINavigationController else { return }
        let controller = segue.controller()
        navigation.viewControllers = [controller]
    }

    func push(_ segue: Screens, animated: Bool = true) {
        guard let navigation = container as? UINavigationController else { return }
        let controller = segue.controller()
        navigation.pushViewController(controller, animated: animated)
    }

    func pop(animated: Bool = true) {
        guard let navigation = container as? UINavigationController else { return }
        navigation.popViewController(animated: animated)
    }

    func present(_ segue: Screens, animated: Bool = true) {
        guard let container = container else { return }
        let controller = segue.controller()
        container.present(controller, animated: animated, completion: nil)
    }

    func dismiss(animated: Bool = true) {
        guard let container = container else { return }
        container.presentedViewController?.dismiss(animated: animated, completion: nil)
    }
}
