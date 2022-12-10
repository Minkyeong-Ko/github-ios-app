//
//  ImageLiteral.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/10.
//

import Foundation
import UIKit

enum ImageLiteral {
    // MARK: - Tab
    static var searchTab: UIImage { .load(systemName: "magnifyingglass.circle") }
    static var searchTabSelected: UIImage { .load(systemName: "magnifyingglass.circle.fill") }
    static var profileTab: UIImage { .load(systemName: "person") }
    static var profileTabSelected: UIImage { .load(systemName: "person.fill") }
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
