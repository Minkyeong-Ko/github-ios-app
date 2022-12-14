//
//  Authorization.swift
//  GithubApp
//
//  Created by Minkyeong Ko on 2022/12/09.
//

import Foundation

struct Authorization: Codable {
    var access_token: String?
    var scope: String?
    var token_type: String?
}
