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
    let disposeBag = DisposeBag()
    // TODO: - dispose 처리 시점
    
    // MARK: - Shared
    static let shared = GithubManager()
    
    private init() {}
    
    // MARK: - 프로필
    
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
                        let userInfo = User(id: data.login ?? "No ID", name: data.name ?? "No Name", imageURL: data.avatarUrl)
                        observer.onNext(userInfo)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }

            return Disposables.create()
        }
    }
    
    func getRepos(of userName: String) -> Observable<Any> {
        let url = "https://api.github.com/users/\(userName)/starred"   

        let accessToken = KeychainManager.shared.getItem(key: "accessToken")
        
        // TODO: - 안전한 방법 찾기
//        guard let accessToken else { return }
        
        let headers: HTTPHeaders = ["Accept": "application/vnd.github.v3+json",
                                    "Authorization": "token \(accessToken as! String)"]
        
        return Observable.create { (observer) -> Disposable in

            AF.request(url, method: .get, parameters: [:], headers: headers)
                .responseDecodable(of: [RepositoryResponse].self) { response in
                    switch response.result {
                    case .success(let data):
                        let result = data.map {
                            Repository(fullName: $0.fullName ?? "No Name",
                                       descriptionField: $0.descriptionField ?? "No Description",
                                       stargazersCount: String($0.stargazersCount ?? 0))
                        }
                        observer.onNext(result)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }

            return Disposables.create()
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
