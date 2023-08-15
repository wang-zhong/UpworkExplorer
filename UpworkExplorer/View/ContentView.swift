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
    
    var body: some View {
        NavigationSplitView {
            FilterRow()
            
            if modelData.jobPosts.count > 0 {
                List(modelData.jobPosts, selection: $selected) { post in
                    HStack {
                        HighlightText(text: post.title, term: modelData.searchTerm)
                            .font(.title2)
                        Spacer()
                        if post.memberSince == "Private" {
                            Image(systemName: "exclamationmark.lock")
                        }
                    }
                }
                .navigationSplitViewColumnWidth(380)
            } else {
                List {
                    HStack {
                        Spacer()
                        RotatingAnimation()
                        Spacer()
                    }
                    .padding(.top, 200)
                }
                .navigationSplitViewColumnWidth(380)
            }

            BottomRow()
        } detail: {
            if selected == nil || modelData.jobPosts.first(where: { $0.id == selected}) == nil {
                Text("Please select one of jobs")
            } else {
                JobDetail(post: modelData.jobPosts.first(where: { $0.id == selected })!)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(minWidth: 1024, minHeight: 860)
            .environmentObject(ModelData())
    }
}
