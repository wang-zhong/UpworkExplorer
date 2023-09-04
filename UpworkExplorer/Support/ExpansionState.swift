//
//  ExpansionState.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/18.
//

import Foundation

struct ExpansionState: RawRepresentable {

    var ids: Set<Int>
    
    let current = 0

    init?(rawValue: String) {
        ids = Set(rawValue.components(separatedBy: ",").compactMap(Int.init))
    }

    init() {
        ids = []
    }

    var rawValue: String {
        ids.map({ "\($0)" }).joined(separator: ",")
    }

    var isEmpty: Bool {
        ids.isEmpty
    }

    func contains(_ id: Int) -> Bool {
        ids.contains(id)
    }

    mutating func insert(_ id: Int) {
        ids.insert(id)
    }

    mutating func remove(_ id: Int) {
        ids.remove(id)
    }

    subscript(groupId: Int) -> Bool {
        get {
            // Expand the current year by default
            ids.contains(groupId) ? true : groupId == current
        }
        set {
            if newValue {
                ids.insert(groupId)
            } else {
                ids.remove(groupId)
            }
        }
    }
}
