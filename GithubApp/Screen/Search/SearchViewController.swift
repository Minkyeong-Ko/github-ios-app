//
//  SearchViewController.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/10.
//

import UIKit

private enum Size {
    // view
    static let horizontalPadding = 20.0
    // search bar
    static let searchBarBorderWidth = 1.0
    static let searchBarCornerRadius = 10.0
    static let searchBarMarginTop = 20.0
    static let searchBarMarginBottom = 28.0
    static let searchBarHeight = 44.0
    // search image
    static let searchImageWidth = 20.0
    // search textfield
    static let leadingTextFieldPadding = 16.0
    static let textFieldWidth = UIScreen.main.bounds.size.width - leadingTextFieldPadding - searchImageWidth - horizontalPadding * 2
    static let textFieldFontSize = 13.0
    // tableView
    static let tableViewRowHeight = 80.0
    // result label
    static let resultLabelMarginBottom = 20.0
    static let resultLabelFontSize = 14.0
    // else
    static let navigationBarHeight = 106.0
}

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let dummy = Repository(fullName: "ReactiveX/RxSwift",
                                          descriptionField: "Reactive Programming in Swift",
                                          stargazersCount: "129")
    
    // MARK: - UI Properties
    
    private let searchBarBackground: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.githubGray.cgColor
        view.layer.borderWidth = Size.searchBarBorderWidth
        view.layer.cornerRadius = Size.searchBarCornerRadius
        return view
    }()
    
    private let searchIcon: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        view.tintColor = .black
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let textfield = UITextField(frame: CGRect(origin: .zero,
                                                  size: CGSize(width: Size.textFieldWidth,
                                                               height: Size.searchBarHeight)))
        textfield.placeholder = "레포지터리를 검색하세요"
        textfield.font = .systemFont(ofSize: Size.textFieldFontSize, weight: .medium)
        textfield.borderStyle = .none
        textfield.clearButtonMode = .whileEditing
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.returnKeyType = .done
        
        return textfield
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과"
        label.font = .systemFont(ofSize: Size.resultLabelFontSize)
        return label
    }()
    
    private let repositoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = Size.tableViewRowHeight
        return tableView
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegation()
        hideKeyboardWhenTappedAround()
        
        view.addSubview(searchBarBackground)
        searchBarBackground.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Size.navigationBarHeight + Size.searchBarMarginTop)
            make.horizontalEdges.equalToSuperview().inset(Size.horizontalPadding)
            make.height.equalTo(Size.searchBarHeight)
        }
        
        view.addSubview(searchIcon)
        searchIcon.snp.makeConstraints { make in
            make.width.equalTo(Size.searchImageWidth)
            make.centerY.equalTo(searchBarBackground)
            make.leading.equalTo(searchBarBackground).inset(Size.horizontalPadding)
        }
        
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.centerY.equalTo(searchBarBackground)
            make.trailing.equalTo(searchBarBackground).inset(Size.horizontalPadding)
            make.leading.equalTo(searchBarBackground).inset(Size.horizontalPadding + Size.searchImageWidth + Size.leadingTextFieldPadding)
        }
        
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Size.horizontalPadding)
            make.top.equalTo(searchBarBackground.snp.bottom).offset(Size.searchBarMarginBottom)
        }
        
        view.addSubview(repositoryTableView)
        repositoryTableView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(Size.resultLabelMarginBottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Func

    private func setDelegation() {
        repositoryTableView.delegate = self
        repositoryTableView.dataSource = self
    }
}

// MARK: - SearchViewController + UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RepositoryTableViewCell()
        cell.configure(repositoryInfo: dummy)
        return cell
    }
}

// MARK: - SearchViewController (hideKeyboardWhenTappedAround)

extension SearchViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
