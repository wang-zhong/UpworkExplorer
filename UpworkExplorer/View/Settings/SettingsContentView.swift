//
//  SettingsContentView.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/18.
//

import SwiftUI

struct SettingsContentView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        List {
            HStack {
                Image(systemName: "bell.badge")
                Toggle("Notification", isOn: $modelData.globalSettings.notification)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
            }
            .frame(maxWidth: 200)
        }
    }
}

struct SettingsContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContentView()
            .environmentObject(ModelData())
    }
}
