//
//  BaseNavigationController.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/10.
//

import UIKit

// MARK: - Size

private enum Size {
    static let navigationBarHeight = 44.0
    static let buttonTrailing = 20
}

final class BaseNavigationController: UINavigationController {
    // MARK: - Properties

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Github"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    private var loginLogoutButton = LoginLogoutButton()
    private var navigationButtons: UIStackView!
    private var navigationBarHeader: UIView!
    private var navigationBarFooter: UIView!

    // MARK: - Life Cycle

    init(rootViewController: UIViewController, title: String, tabBarItem: UITabBarItem) {
        super.init(rootViewController: rootViewController)
        self.tabBarItem = tabBarItem
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
    }
    
    private func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(navigationBar.snp.top)
            make.height.equalTo(Size.navigationBarHeight)
        }
        
        view.addSubview(loginLogoutButton)
        loginLogoutButton.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.top)
            make.height.equalTo(Size.navigationBarHeight)
            make.trailing.equalToSuperview().inset(Size.buttonTrailing)
        }
        
        setNavigationBarBackground(to: .githubGray)
    }

    private func configUI() {}

    // MARK: - Func

    private func setNavigationBarBackground(to color: UIColor) {
        navigationBar.backgroundColor = color
    }
}
