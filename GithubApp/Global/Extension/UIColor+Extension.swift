//
//  UIColor+Extension.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/10.
//

import UIKit

extension UIColor {
    static let githubGray: UIColor = .init(hex: "8a8a8e")
    static let githubLightGray: UIColor = .init(hex: "F6F6F6")
    static let githubBlue: UIColor = .init(hex: "24292F")
    static let githubYellow: UIColor = .init(hex: "FFC531")
}

extension UIColor {
    convenience init(hex: String, alpha: Double = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: Double(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
