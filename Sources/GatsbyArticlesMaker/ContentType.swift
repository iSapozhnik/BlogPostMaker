//
//  ContentType.swift
//  GatsbyArticlesMaker
//
//  Created by Ivan Sapozhnik on 9/21/19.
//

import Foundation

enum ContentType: String {
    case Article
    case Page
    
    init(with choice: String) {
        if let contentType = ContentType(rawValue: choice) {
            self = contentType
        } else {
            self = .Article
        }
    }
}

extension ContentType {
    var directoryPath: String {
        switch self {
        case .Article:
            return "/articles"
        case .Page:
            return "/pages"
        }
    }
}
