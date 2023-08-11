//
//  UpworkExplorerApp.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import SwiftUI

@main
struct UpworkExplorerApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 1024, minHeight: 860)
                .environmentObject(modelData)
        }
    }
}
