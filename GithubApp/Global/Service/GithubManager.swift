//
//  GithubManager.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/08.
//

import Foundation
import UIKit

import Alamofire
import RxSwift

class GithubManager {
    
    // MARK: - Rx
    
    let repositoriesSubject = BehaviorSubject<[Repository]>(value: [])
    let searchRepositoriesSubject = BehaviorSubject<[Repository]>(value: [])
    let disposeBag = DisposeBag()
    
    // TODO: - dispose 처리 시점
    
    // MARK: - Shared
    
    static let shared = GithubManager()
    
    private init() {}
    
    // MARK: - Properties
    var currentUser: User?

    // 유저 정보
    func getUser() -> Observable<Any> {
        let url = "https://api.github.com/user"
        let accessToken = KeychainManager.shared.getItem(key: "accessToken")
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github+json",
                                    "Authorization": "token \(accessToken as! String)"]
        
        return Observable.create { (observer) -> Disposable in

            AF.request(url, method: .get, parameters: [:], headers: headers)
                .responseDecodable(of: UserResponse.self) { response in
                    switch response.result {
                    case .success(let data):
                        if let id = data.login, let name = data.name, let imageURL = data.avatarUrl {
                            let userInfo = User(id: id, name: name, imageURL: imageURL)
                            self.currentUser = userInfo
                            observer.onNext(userInfo)
                            observer.onCompleted()
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }

            return Disposables.create()
        }
    }
    
    // 유저 이미지
    func getProfileImage(from imageURL: String) -> Observable<UIImage?> {
        return Observable.create { (observer) -> Disposable in
            DispatchQueue.global().async {
                if let url = URL(string: imageURL), let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    observer.onNext(image)
                    observer.onCompleted()
                }
            }  
            
            return Disposables.create()
        }
    }
    
    // 유저가 Star 저장한 레포지터리
    func getRepos(of userName: String) {
        let url = "https://api.github.com/users/\(userName)/starred"   

        let accessToken = KeychainManager.shared.getItem(key: "accessToken")
        
        guard let accessToken else { return }
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json",
                                    "Authorization": "token \(accessToken as! String)"]
        
        AF.request(url, method: .get, parameters: [:], headers: headers)
                .responseDecodable(of: [RepositoryResponse].self) { response in
                    switch response.result {
                    case .success(let data):
                        let result = data.map {
                            Repository(fullName: $0.fullName!,
                                       descriptionField: $0.descriptionField ?? "No Description",
                                       stargazersCount: String($0.stargazersCount ?? 0))
                        }
                        self.repositoriesSubject.onNext(result)
                    case .failure(let error):
                        self.repositoriesSubject.onError(error)
                    }
                }
    }
    
    // 레포지터리 검색
    func searchRepoTest(with text: String) {
        let url = "https://api.github.com/search/repositories?q=\(text)&page=1"
        let accessToken = KeychainManager.shared.getItem(key: "accessToken")
        
        var headers: HTTPHeaders = HTTPHeaders()
        
        do {
            if try LoginManager.shared.loginStatusSubject.value() == .loggedIn {
                headers = ["Accept": "application/vnd.github.v3+json",
                                        "Authorization": "token \(accessToken as! String)"]
            } else {
                headers = ["Accept": "application/vnd.github.v3+json"]
            }
        } catch {
            print(error)
        }
        
        AF.request(url, method: .get, parameters: [:], headers: headers)
            .responseDecodable(of: SearchRepositoriesResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let result = data.items?.map {
                        Repository(fullName: $0.fullName!,
                                   descriptionField: $0.descriptionField ?? "No Description",
                                   stargazersCount: String($0.stargazersCount ?? 0))
                    }
                    if let result {
                        self.searchRepositoriesSubject.onNext(result)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // 레포지터리 Star
    public func unstarRepository(repo: String) {
        let url = "https://api.github.com/user/starred/\(repo)"
        let accessToken = KeychainManager.shared.getItem(key: "accessToken")
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json",
                                    "Authorization": "token \(accessToken as! String)"]
        
        AF.request(url, method: .delete, parameters: [:], headers: headers)
            .response { response in
                switch response.result {
                case .success(_):
                    self.getRepos(of: self.currentUser?.id ?? "")
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // 레포지터리 Unstar
    public func starRepository(repo: String) {
        let url = "https://api.github.com/user/starred/\(repo)"
        let accessToken = KeychainManager.shared.getItem(key: "accessToken")
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json",
                                    "Authorization": "token \(accessToken as! String)"]
        
        AF.request(url, method: .put, parameters: [:], headers: headers)
            .response { response in
                switch response.result {
                case .success(_):
                    self.getRepos(of: self.currentUser?.id ?? "")
                case .failure(let error):
                    print(error)
                }
            }
    }
}
