//
//  ContentView.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationSplitView {
            Sidebar(menuItems: modelData.sideMenuItems, selection: $modelData.activeFeedId)
                .frame(minWidth: 250)
        } detail: {
            switch modelData.activeFeedId {
            case 2:
                SettingsContentView()
            case 1:
                FeedView()
            default:
                JobsContentView()
            }
        }
        .onChange(of: modelData.activeFeedId) { newValue in
            modelData.page = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(minWidth: 1324, minHeight: 860)
            .environmentObject(ModelData.shared)
    }
}
