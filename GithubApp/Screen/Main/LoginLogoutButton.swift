//
//  LoginLogoutButton.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/10.
//

import UIKit

import SnapKit

final class LoginLogoutButton: UIButton {
    
    // MARK: - Properties
    
    var isLogin = false
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setTitle("로그인", for: .normal)
        addTarget(self, action: #selector(isLoginButtonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func

    func configUI() {
        titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
    }
    
    @objc func isLoginButtonPressed() {
        if isLogin {
            logout()
        } else {
            login()
        }
    }
    
    func login() {
        isLogin = true
        LoginManager.shared.requestCode()
    }
    
    func logout() {
        isLogin = false
        LoginManager.shared.logout()
    }
    
    func toggleButtonTitle() {
        if isLogin {
            setTitle("로그아웃", for: .normal)
        } else {
            setTitle("로그인", for: .normal)
        }
    }
    
}
