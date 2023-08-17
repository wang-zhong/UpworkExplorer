//
//  BottomRow.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/15.
//

import SwiftUI

struct BottomRow: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        VStack {
            Divider().padding(.horizontal)
            HStack {
                Picker(selection: $modelData.limit, label: Text("Limit")) {
                    Text("20").tag(20)
                    Text("40").tag(40)
                    Text("100").tag(100)
                    Text("200").tag(200)
                }
                .frame(maxWidth: 100)

                Spacer()
                
                HStack {
                    Button {
                        modelData.page = modelData.page - 1
                    } label: {
                        Label("Prev", systemImage: "chevron.left")
                            .labelStyle(.iconOnly)
                    }
                    Text("\(modelData.page) / \(modelData.totalPage)")
                    Button {
                        modelData.page = modelData.page + 1
                    } label: {
                        Label("Prev", systemImage: "chevron.right")
                            .labelStyle(.iconOnly)
                    }
                }
                
                Spacer()
                
                Toggle("Notification", isOn: $modelData.preferNotification)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: .green))
            }
            .padding(.horizontal)
            .padding(.bottom, 6)
        }
    }
}

struct BottomRow_Previews: PreviewProvider {
    static var previews: some View {
        BottomRow()
            .environmentObject(ModelData())
    }
}
