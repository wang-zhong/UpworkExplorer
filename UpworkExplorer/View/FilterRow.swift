//
//  FilterRow.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import SwiftUI

struct FilterRow: View {
    @EnvironmentObject var modelData: ModelData
    @State private var searchTerm = UserDefaults.standard.string(forKey: "searchTerm") ?? ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search...", text: $searchTerm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        modelData.searchTerm = searchTerm
                    }
                Toggle("US Only", isOn: $modelData.isUsOnly)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
            }
            .padding(.horizontal)
            
            Divider().padding(.horizontal)
        }
    }
}

struct FilterRow_Previews: PreviewProvider {
    static var previews: some View {
        FilterRow()
            .environmentObject(ModelData())
    }
}
