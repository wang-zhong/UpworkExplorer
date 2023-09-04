//
//  Sidebar.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/18.
//

import SwiftUI

struct Sidebar: View {
    @SceneStorage("expansionState") private var expansionState = ExpansionState()
    var menuItems: [SideMenuItem]

    @Binding var selection: Int?
    
    var body: some View {
        List(selection: $selection) {
            DisclosureGroup(isExpanded: $expansionState[0]) {
                ForEach(menuItems.sorted(by: { $0.displayOrder < $1.displayOrder }).filter { $0.group == 0 || $0.group == 1 }) { item in
                    Label(item.text, systemImage: item.icon)
                }
            } label: {
                Label("Feed", systemImage: "dot.radiowaves.left.and.right")
            }
            ForEach(menuItems.filter { $0.group == 2 }) { item in
                Label(item.text, systemImage: item.icon)
            }
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    
    static var previews: some View {
        Sidebar(menuItems: ModelData.shared.sideMenuItems, selection: .constant(0))
    }
}
