//
//  LoginManager.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/14.
//

import UIKit

import Alamofire
import RxSwift

enum LoginStatus {
    case inProgress
    case loggedIn
    case loggedOut
}

class LoginManager {
    // MARK: - Rx
    let loginStatusSubject = BehaviorSubject<LoginStatus>(value: .loggedOut)
    
    // MARK: - Shared
    static let shared = LoginManager()
    
    // MARK: - Life Cycle
    private init() {}
    
    // MARK: - Properties
    let client_id = Bundle.main.clientID
    let client_secret = Bundle.main.clientSecret
    
    func requestCode() {
        loginStatusSubject.onNext(.inProgress)
        let scope = "repo,user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(client_id)&scope=\(scope)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    func requestAccessToken(with code: String) {
        let url = "https://github.com/login/oauth/access_token"

        let parameters = ["client_id": client_id,
                          "client_secret": client_secret,
                          "code": code]

        let headers: HTTPHeaders = ["Accept": "application/json"]

        AF.request(url, method: .post, parameters: parameters, headers: headers)
            .responseDecodable(of: Authorization.self) { response in
            switch response.result {
            case let .success(data):
                let accessToken = data.access_token

                if let accessToken {
                    let _ = KeychainManager.shared.addItem(key: "accessToken", pwd: accessToken)
                    
                    self.loginStatusSubject.onNext(.loggedIn)
                }

            case let .failure(error):
                print(error)
            }
        }
    }

    func logout() {
        let _ = KeychainManager.shared.deleteItem(key: "accessToken")
        loginStatusSubject.onNext(.loggedOut)
    }
}
