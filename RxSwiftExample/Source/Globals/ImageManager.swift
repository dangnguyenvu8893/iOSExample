//
//  ImageManager.swift
//  RxSwiftExample
//
//  Created by Vu Dang on 10/20/19.
//  Copyright © 2019 Vu Dang. All rights reserved.
//

import Foundation

struct ImageManager {
    
}

extension ImageManager {
    enum BackdropSize: String, CaseIterable {
        case w300
        case w780
        case w1280
        case original
    }
    
    enum LogoSize: String, CaseIterable {
        case w45
        case w92
        case w154
        case w300
        case w500
        case original
    }
    
    enum PosterSize: String, CaseIterable {
        case w92
        case w154
        case w185
        case w342
        case w500
        case w780
        case original
    }
    
    enum ProfileSize: String, CaseIterable {
        case w45
        case w185
        case h632
        case original
    }
    
    static func getImageString<T: RawRepresentable>(size: T, path: String?) -> String? where T.RawValue == String {
        guard let path = path else { return nil}
        return "\(APIConfig.baseImageURl)/\(size.rawValue)/\(path)"
    }
}
