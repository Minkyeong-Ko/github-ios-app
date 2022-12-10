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

class MainTabViewController: UITabBarController {
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
        tabBar.barTintColor = .githubGray
    }

    func render() {}

    // MARK: - Func

    private func setTabViewControllers() {
        let searchTab = BaseNavigationController(
            rootViewController: ProfileViewController(),
            title: TabBarLiteral.search(),
            tabBarItem: UITabBarItem(
                title: TabBarLiteral.search(),
                image: ImageLiteral.searchTab,
                selectedImage: ImageLiteral.searchTabSelected
            )
        )
        let profileTab = BaseNavigationController(
            rootViewController: ProfileViewController(),
            title: TabBarLiteral.profile(),
            tabBarItem: UITabBarItem(
                title: TabBarLiteral.profile(),
                image: ImageLiteral.profileTab,
                selectedImage: ImageLiteral.profileTabSelected
            )
        )

        setViewControllers(
            [searchTab, profileTab],
            animated: true
        )
    }
}
