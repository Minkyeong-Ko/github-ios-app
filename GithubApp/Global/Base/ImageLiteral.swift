//
//  ImageLiteral.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/10.
//

import Foundation
import UIKit

enum ImageLiteral {
    // MARK: Tab
    static var searchTab: UIImage { .load(systemName: "magnifyingglass") }
    static var searchTabSelected: UIImage { .load(systemName: "magnifyingglass.circle.fill") }
    static var profileTab: UIImage { .load(systemName: "person") }
    static var profileTabSelected: UIImage { .load(systemName: "person.fill") }
    
    // MARK: Symbols
    static var userProfileSymbol: UIImage { .load(systemName: "person") }
    static var repositorySymbol: UIImage { .load(systemName: "book.closed") }
    static var starFill: UIImage { .load(systemName: "star.fill") }
    static var starOutline: UIImage { .load(systemName: "star") }
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName) else {
            return UIImage()
        }
        image.accessibilityIdentifier = imageName
        return image
    }

    static func load(systemName: String) -> UIImage {
        guard let image = UIImage(systemName: systemName, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = systemName
        return image
    }

    static func load(named: String, color: UIColor) -> UIImage {
        return UIImage.load(named: named).withTintColor(color)
    }

    static func load(systemName: String, color: UIColor) -> UIImage {
        return UIImage.load(systemName: systemName).withTintColor(color)
    }
}
