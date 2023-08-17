//
//  Settings.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import Foundation

struct Settings {
    var usOnly = UserDefaults.standard.bool(forKey: "usOnly")
    var preferNotification = UserDefaults.standard.bool(forKey: "notification")
    var searchTerm = UserDefaults.standard.string(forKey: "searchTerm") ?? ""
    var total = 0
    var page = 1
    var limit = UserDefaults.standard.integer(forKey: "limit") == 0 ? 40 : UserDefaults.standard.integer(forKey: "limit")
}
