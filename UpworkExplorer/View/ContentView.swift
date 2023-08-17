//
//  ContentView.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State var selected: Int?
    @State var selectedJob: JobPost?
    
    var body: some View {
        NavigationSplitView {
            FilterRow()
            
            if modelData.jobPosts.count > 0 {
                List(modelData.jobPosts, selection: $selected) { post in
                    HStack {
                        HighlightText(text: post.title, term: modelData.searchTerm)
                            .font(.title2)
                        Spacer()
                        if post.isPrivate == "Private" {
                            Image(systemName: "exclamationmark.lock")
                        }
                    }
                }
                .navigationSplitViewColumnWidth(min: 380, ideal: 400, max: 600)
                .onChange(of: selected, perform: { newValue in
                    selectedJob = modelData.jobPosts.first(where: { $0.id == newValue })!
                })
            } else {
                List {
                    HStack {
                        Spacer()
                        RotatingAnimation()
                        Spacer()
                    }
                    .padding(.top, 200)
                }
                .navigationSplitViewColumnWidth(min: 380, ideal: 400, max: 600)
            }

            BottomRow()
        } detail: {
            if selectedJob == nil {
                Text("Please select one of jobs")
            } else {
                JobDetail(post: selectedJob!)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(minWidth: 1200, minHeight: 860)
            .environmentObject(ModelData())
    }
}
