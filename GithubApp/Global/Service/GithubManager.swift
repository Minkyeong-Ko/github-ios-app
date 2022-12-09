//
//  GithubManager.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/08.
//

import Foundation
import UIKit

import Alamofire

class GithubManager {
    let client_id = Bundle.main.clientID
    let client_secret = Bundle.main.clientSecret
    
    static let shared = GithubManager()
    
    private init() {}
    
    // MARK: - 로그인 로그아웃
    
    func requestCode() {
        print("client_id: \(client_id)")
        print("client_secret: \(client_secret)")
        
        let scope = "repo,user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(client_id)&scope=\(scope)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            // redirect to scene(_:openURLContexts:) if user authorized
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
                print(data)
                let accessToken = data.access_token
                
                if let accessToken {
                    if KeychainManager.shared.getItem(key: "accessToken") == nil {
                        let _ = KeychainManager.shared.addItem(key: "accessToken", pwd: accessToken)
                    } else {
                        let _ = KeychainManager.shared.updateItem(value: accessToken, key: "accessToken")
                    }
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func logout() {
        let _ = KeychainManager.shared.deleteItem(key: "accessToken")
    }
    
    // MARK: - 프로필
    
    func getUser() {
        let url = "https://api.github.com/user"
        let accessToken = KeychainManager.shared.getItem(key: "accessToken")
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github+json",
                                    "Authorization": "token \(accessToken as! String)"]

        AF.request(url, method: .get, parameters: [:], headers: headers)
            .responseDecodable(of: UserResponse.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
                print(data.bio ?? "")
                print(data.avatarUrl ?? "")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRepos() {
        let url = "https://api.github.com/users/Minkyeong-Ko/starred"   // temp url

        let accessToken = KeychainManager.shared.getItem(key: "accessToken")
        
        guard let accessToken else { return }
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json",
                                    "Authorization": "token \(accessToken as! String)"]
        
        AF.request(url, method: .get, parameters: [:], headers: headers)
            .responseDecodable(of: [RepositoryResponse].self) { response in
                switch response.result {
                case .success(let data):
//                    completion(data)
                    print(data)
                    data.forEach {
                        print("-------------")
                        print($0.fullName ?? "")
                        print($0.descriptionField ?? "")
                        print($0.stargazersCount ?? "")
                        print($0.topics ?? "")
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // MARK: - 레포지터리 검색
    
    func searchRepoTest() {
        let url = "https://api.github.com/search/repositories?q=rxSwift&page=1" // temp url
        let accessToken = KeychainManager.shared.getItem(key: "accessToken")
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json",
                                    "Authorization": "token \(accessToken as! String)"]
        
        AF.request(url, method: .get, parameters: [:], headers: headers)
            .responseDecodable(of: SearchRepositoriesResponse.self) { response in
                switch response.result {
                case .success(let data):
//                    completion(data)
                    print(data)
                    data.items?.forEach{
                        print($0.fullName ?? "")
                        print($0.descriptionField ?? "")
                        print($0.stargazersCount ?? "")
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // MARK: - Star / Unstar 업데이트
    public func unstarRepository() {
        let url = "https://api.github.com/user/starred/JaeYeopHan/Interview_Question_for_Beginner"
        let accessToken = KeychainManager.shared.getItem(key: "accessToken")
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json",
                                    "Authorization": "token \(accessToken as! String)"]
        
        AF.request(url, method: .delete, parameters: [:], headers: headers)
            .response { result in
                print(result)
            }
    }
    
    public func starRepository() {
        let url = "https://api.github.com/user/starred/JaeYeopHan/Interview_Question_for_Beginner"
        let accessToken = KeychainManager.shared.getItem(key: "accessToken")
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json",
                                    "Authorization": "token \(accessToken as! String)"]
        
        AF.request(url, method: .put, parameters: [:], headers: headers)
            .response { result in
                print(result)
            }
    }
}
