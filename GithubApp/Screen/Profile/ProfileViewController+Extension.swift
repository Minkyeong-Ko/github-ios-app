//
//  ProfileViewController+Extension.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/14.
//

import UIKit

// MARK: - ProfileViewController + UITableViewDelegate, UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RepositoryTableViewCell()
        cell.repository = tableViewDataSource[indexPath.row]
        cell.configure(repositoryInfo: tableViewDataSource[indexPath.row])
        return cell
    }
}
