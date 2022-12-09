//
//  ViewController.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/08.
//

import UIKit

import SnapKit

class ViewController: BaseViewController {
    
    // MARK: - UI Properties
    var loginStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인 전 초기 상태"
        return label
    }()
    
    private lazy var testLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
        button.backgroundColor = .orange
        return button
    }()
    private lazy var testlogOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.addTarget(self, action: #selector(logoutButtonDidTapped), for: .touchUpInside)
        button.backgroundColor = .systemTeal
        return button
    }()
    
    private lazy var testStarredRepositories: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 후 스타 한 레포지터리들 확인", for: .normal)
        button.addTarget(self, action: #selector(showStarredRepositories), for: .touchUpInside)
        button.backgroundColor = .orange
        return button
    }()
    
    private lazy var testSearchRepositories: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 상관 없이 검색", for: .normal)
        button.addTarget(self, action: #selector(searchRepositories), for: .touchUpInside)
        button.backgroundColor = .yellow
        return button
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func render() {
        view.addSubview(testLoginButton)
        testLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        view.addSubview(testlogOutButton)
        testlogOutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(testLoginButton.snp.bottom).offset(30)
        }
        view.addSubview(testStarredRepositories)
        testStarredRepositories.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(testlogOutButton.snp.bottom).offset(30)
        }
        view.addSubview(testSearchRepositories)
        testSearchRepositories.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(testStarredRepositories.snp.bottom).offset(30)
        }
        
        view.addSubview(loginStatusLabel)
        loginStatusLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Func

    @objc func loginButtonDidTapped() {
        GithubManager.shared.requestCode()
        loginStatusLabel.text = "로그인 클릭됨 (완료여부는 나중에)"
    }
    
    @objc func logoutButtonDidTapped() {
        GithubManager.shared.logout()
        loginStatusLabel.text = "로그아웃 클릭됨 (완료여부는 나중에)"
    }
    
    @objc func showStarredRepositories() {
        GithubManager.shared.getRepos()
    }
    
    @objc func searchRepositories() {
        GithubManager.shared.searchRepoTest()
    }
}

