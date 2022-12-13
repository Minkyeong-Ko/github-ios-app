//
//  MainTabViewController.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/10.
//

import UIKit

import SnapKit

// MARK: - Literal

private enum TabBarLiteral: String {
    case search
    case profile

    func callAsFunction() -> String {
        return rawValue.capitalized
    }
}

final class MainTabViewController: UITabBarController {
    // MARK: - Properties
    
    let loginLogoutButton = LoginLogoutButton()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
    }

    func configUI() {
        setTabViewControllers()
        tabBar.tintColor = .white
        view.backgroundColor = .systemBackground
        tabBar.barTintColor = .githubBlue
    }

    func render() {}

    // MARK: - Func

    private func setTabViewControllers() {
        let searchTab = SearchViewController()
        searchTab.tabBarItem = UITabBarItem(title: TabBarLiteral.search(), image: ImageLiteral.searchTab, selectedImage: ImageLiteral.searchTab)
        let profileTab = ProfileViewController()
        profileTab.tabBarItem = UITabBarItem(title: TabBarLiteral.profile(), image: ImageLiteral.profileTab, selectedImage: ImageLiteral.profileTabSelected)
        
        setViewControllers(
            [searchTab, profileTab],
            animated: true
        )
    }
}
