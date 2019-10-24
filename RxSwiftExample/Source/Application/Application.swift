//
//  Application.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/19/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import RxSwift
import RxCocoa

class Application {
    static let shared = Application()
    
    private weak var window: UIWindow?
    
    func configureMainScreen(in window: UIWindow?) {
        self.window = window
        self.window?.backgroundColor = .black
        self.window?.makeKeyAndVisible()
        setHomeScreen()
        configureLib()
    }
        
    private func setHomeScreen() {
        let navigation = UINavigationController()
        let navigator = Navigator(container: navigation)
        Navigator.shared = navigator
        window?.rootViewController = navigation
        navigator.setRoot(.home)
    }
    
    private func configureLib() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
