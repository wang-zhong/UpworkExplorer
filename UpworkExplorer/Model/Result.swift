//
//  Result.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/15.
//

import Foundation

struct Result: Codable {
    var total = "0"
    var page = "1"
    var limit = "40"
    var jobs: [JobPost]
}
