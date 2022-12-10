//
//  LoginLogoutButton.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/10.
//

import UIKit

final class LoginLogoutButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("로그인", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
