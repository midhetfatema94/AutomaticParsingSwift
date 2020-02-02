//
//  GithubProfileModel.swift
//  AutomatincParsing
//
//  Created by Waveline Media on 2/2/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

struct GithubProfile: Codable {
    let id: Int!
    let avatarUrl: URL?
    let name: String?
    let location: String?
    let repos: Int?
    let followers: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar_url"
        case name
        case location
        case repos = "public_repos"
        case followers
    }
}
