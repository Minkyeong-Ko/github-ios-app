//
//  GithubApp++Bundle.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/09.
//

import Foundation

extension Bundle {
    var clientID: String {
        guard let file = self.path(forResource: "ClientInfo", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["CLIENT_ID"] as? String else {
            fatalError("Client ID를 입력해주세요.")
        }
        return key
    }
    
    var clientSecret: String {
        guard let file = self.path(forResource: "ClientInfo", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["CLIENT_SECRET"] as? String else {
            fatalError("Client Secret을 입력해주세요.")
        }
        return key
    }
}
