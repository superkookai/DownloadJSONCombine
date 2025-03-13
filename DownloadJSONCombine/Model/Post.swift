//
//  Post.swift
//  DownloadJSONCombine
//
//  Created by Weerawut Chaiyasomboon on 13/03/2568.
//

import Foundation

struct Post: Decodable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
