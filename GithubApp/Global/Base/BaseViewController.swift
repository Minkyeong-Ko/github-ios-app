//
//  BaseViewController.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/09.
//

import UIKit

import SnapKit

private enum Size {
    // font
    static let logoFontSize = 34.0
    // navigation bar
    static let navigationBarHeight = 106.0
    static let horizontalPadding = 28.0
    static let bottomPadding = 24.0
}

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    private var statusBarHeight = 0.0
    
    // MARK: - UI Properties
    
    let navigationBackgroundView = UIView()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Github"
        label.font = .systemFont(ofSize: Size.logoFontSize, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let loginButton = LoginLogoutButton()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStatusBarHeight()
        
        render()
        configUI()
    }

    func render() {
        // auto layout 관련 코드들 모아놓는 곳
        
        view.addSubview(navigationBackgroundView)
        navigationBackgroundView.backgroundColor = .githubBlue
        navigationBackgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(Size.navigationBarHeight + statusBarHeight)
        }
        
        view.addSubview(logoLabel)
        logoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Size.horizontalPadding)
            make.bottom.equalTo(navigationBackgroundView).inset(Size.bottomPadding)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(logoLabel)
            make.trailing.equalToSuperview().inset(Size.horizontalPadding)
        }
    }

    func configUI() {
        // UI 관련 코드들 모아놓는 곳
        
        view.backgroundColor = .systemBackground
    }
    
    private func getStatusBarHeight() {
        let window = UIApplication.shared.windows.first
        let top = window?.safeAreaInsets.top
        self.statusBarHeight = top!
    }
}

