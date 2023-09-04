//
//  SideMenuItem.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/18.
//

import Foundation

struct SideMenuItem: Identifiable {
    var id: Int
    var text: String
    var icon: String
    var displayOrder: Int
    var group: Int // 0: feed, 1: add feed, 2: settings
}
