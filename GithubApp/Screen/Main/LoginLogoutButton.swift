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
    
    private var isLogin = false
    
    // MARK: - Life Cycle

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
        toggleButtonTitle()
        // TODO: - 로그인 요청
        // TODO: - 로그인 성공하면 ProfileViewController에 알리기
        // TODO: - 로그인 성공하면 버튼 토글
        print("로그인")
    }
    
    func logout() {
        isLogin = false
        toggleButtonTitle()
        print("로그아웃")
        // TODO: - 로그아웃
    }
    
    func toggleButtonTitle() {
        if isLogin {
            setTitle("로그아웃", for: .normal)
        } else {
            setTitle("로그인", for: .normal)
        }
    }
    
}
