//
//  ProfileViewController.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/10.
//

import UIKit

private enum Size {
    // view
    static let horizontalPadding = 20.0
    // profile
    static let profileViewHeight = 128
    // border line
    static let borderLineHeight = 5
    static let borderLineMarginBottom = 14.0
    // repository label
    static let repositoryLabelFontSize = 14.0
    static let repositoryLabelMarginBottom = 20.0
    // tableView
    static let tableViewRowHeight = 80.0
    // stackView
    static let loginStackViewSpacing = 20.0
    // else
    static let navigationBarHeight = 106.0
}

final class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let dummy = Repository(fullName: "ReactiveX/RxSwift",
                                          descriptionField: "Reactive Programming in Swift",
                                          stargazersCount: "129")
    
    
    // MARK: - UI Properties
    
    private let profileView = UserProfileView()
    
    private let repositoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = Size.tableViewRowHeight
        
        return tableView
    }()
    
    private let askLoginBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private let askLoginStackView: UIStackView = {
        let label = UILabel()
        label.text = "로그인이 필요합니다."
        
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.configuration = UIButton.Configuration.filled()
        button.tintColor = .githubLightGray
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.githubGray, for: .highlighted)
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Size.loginStackViewSpacing
        
        return stackView
    }()
    
    private let borderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .githubLightGray
        return view
    }()
    
    private let repositoryLabel: UILabel = {
        let label = UILabel()
        label.text = "저장한 레포지터리 목록"
        label.font = .systemFont(ofSize: Size.repositoryLabelFontSize)
        return label
    }()
    
    // MARK: - Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAskLoginButton()
        setDelegation()
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Size.navigationBarHeight)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Size.profileViewHeight)
        }
        
        view.addSubview(borderLine)
        borderLine.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(Size.borderLineHeight)
            make.top.equalTo(profileView.snp.bottom)
        }
        
        view.addSubview(repositoryLabel)
        repositoryLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Size.horizontalPadding)
            make.top.equalTo(borderLine.snp.bottom).offset(Size.borderLineMarginBottom)
        }
        
        view.addSubview(repositoryTableView)
        repositoryTableView.snp.makeConstraints { make in
            make.top.equalTo(repositoryLabel.snp.bottom).offset(Size.repositoryLabelMarginBottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(askLoginBackgroundView)
        askLoginBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Size.navigationBarHeight)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        askLoginBackgroundView.addSubview(askLoginStackView)
        askLoginStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Func
    
    func setAskLoginButton() {
        let button = askLoginStackView.arrangedSubviews[1] as! UIButton
        button.addTarget(self, action: #selector(testLoginSuccess), for: .touchUpInside)
    }
    
    @objc func testLoginSuccess() {
        // TODO: - 로그인 요청
        // TODO: - 로그인 성공하면 view 없애기
        // TODO: - 로그인 성공하면 유저 프로필 업데이트
        // TODO: - 로그인 성공하면 테이블 뷰 data 업데이트
        askLoginBackgroundView.alpha = 0.0
    }
    
    // TODO: - 로그아웃 시 다시 askLoginBackgroundView 보이기
    
    private func setDelegation() {
        repositoryTableView.delegate = self
        repositoryTableView.dataSource = self
    }
}

// MARK: - ProfileViewController + UITableViewDelegate, UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: - 레포지터리 개수 받아와서 적용
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RepositoryTableViewCell()
        // TODO: - 실제 datasource 반영
        cell.configure(repositoryInfo: dummy)
        return cell
    }
}
