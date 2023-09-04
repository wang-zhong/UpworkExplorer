//
//  UpworkExplorerApp.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import SwiftUI

@main
struct UpworkExplorerApp: App {
    @StateObject private var modelData = ModelData.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 1324, minHeight: 860)
                .environmentObject(modelData)
        }
    }
}
