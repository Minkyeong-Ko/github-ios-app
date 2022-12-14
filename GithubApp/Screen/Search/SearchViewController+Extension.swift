//
//  SearchViewController+Extension.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/14.
//

import UIKit

// MARK: - SearchViewController + UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RepositoryTableViewCell()
        cell.configure(repositoryInfo: tableViewDataSource[indexPath.row])
        return cell
    }
}

// MARK: - SearchViewController + hideKeyboardWhenTappedAround

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

// MARK: - SearchViewController + UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboardWhenTappedAround()
        
        textField.resignFirstResponder()
        
        let text = textField.text ?? ""
        GithubManager.shared.searchRepoTest(with: text.replacingOccurrences(of: " ", with: ""))
        
        return true
    }
}
