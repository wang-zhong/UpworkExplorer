//
//  GlobalSettings.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/18.
//

import Foundation

struct GlobalSettings {
    static var shared = GlobalSettings()
    private var _notification = UserDefaults.standard.bool(forKey: "notification")
    
    var notification: Bool {
        get {
            return _notification
        }
        
        set(value) {
            _notification = value
            UserDefaults.standard.set(_notification, forKey: "notification")
        }
    }
}
