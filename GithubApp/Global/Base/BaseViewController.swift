//
//  BaseViewController.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/09.
//

import UIKit

import SnapKit

class BaseViewController: UIViewController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
    }

    func render() {
        // auto layout 관련 코드들 모아놓는 곳
    }

    func configUI() {
        // UI 관련 코드들 모아놓는 곳
        view.backgroundColor = .systemBackground
    }
}

