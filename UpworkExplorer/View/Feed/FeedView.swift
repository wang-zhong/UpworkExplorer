//
//  FeedView.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/21.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var andText = ""
    @State var andList: [String] = []
    @State var orText = ""
    @State var orList: [String] = []
    @State var feedName = ""
    @State var isCustomName = false
    @State var isUSOnly = false
    @State var jobType = 0
    @State var displayOrder = 0
    
    func setFeedName() {
        guard isCustomName == false || feedName.isEmpty else {
            return
        }

        var temp: [String] = []
        
        if andList.count > 0 {
            temp.append("(\(andList.joined(separator: " and ")))")
        }
        if orList.count > 0 {
            temp.append("(\(orList.joined(separator: " or ")))")
        }
        feedName = temp.joined(separator: " + ")
    }

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Feed Name").font(.headline)
                TextField("", text: $feedName)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                    .onSubmit {
                        isCustomName = true
                    }
            }

            Toggle("US Only", isOn: $isUSOnly)
                .toggleStyle(SwitchToggleStyle(tint: .green))
                .padding(.top)

            Picker(selection: $jobType, label: Text("Job Type")) {
                Text("Hourly").tag(1)
                Text("Fixed").tag(2)
                Text("Both").tag(0)
            }
            .pickerStyle(RadioGroupPickerStyle())
            .padding(.top)
            
            Group {
                Text("And Conditions").font(.headline)
                    .padding(.top)
                HStack {
                    TextField("", text: $andText)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200)
                        .onSubmit {
                            andList.append(andText)
                            andText = ""
                            setFeedName()
                        }
                    Button {
                        andList.append(andText)
                        andText = ""
                        setFeedName()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                Text(andList.joined(separator: " and "))
            }
            
            Group {
                Text("OR Conditions").font(.headline)
                    .padding(.top)
                HStack {
                    TextField("", text: $orText)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200)
                        .onSubmit {
                            orList.append(orText)
                            orText = ""
                            setFeedName()
                        }
                    Button {
                        orList.append(orText)
                        orText = ""
                        setFeedName()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                Text(orList.joined(separator: " or "))
            }
            
            Group {
                Text("Display Order")
                    .font(.headline)
                    .padding(.top)
                TextField("", value: $displayOrder, format: .number)
                    .frame(width: 200)
                    .textFieldStyle(.roundedBorder)
            }
            
            Button {
                let feedId = modelData.createFeed(
                    name: feedName,
                    usOnly: isUSOnly,
                    andText: andList.joined(separator: "&&"),
                    orText: orList.joined(separator: "&&"),
                    jobType: jobType,
                    displayOrder: displayOrder
                )
                modelData.activeFeedId = feedId
            } label: {
                Text("Create a feed")
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
            .environmentObject(ModelData.shared)
    }
}
