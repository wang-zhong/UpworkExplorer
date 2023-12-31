//
//  JobsContentView.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/18.
//

import SwiftUI

struct JobsContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State var selected: Int?
    @State var selectedJob: JobPost?
    @State var searchText = ""

    var body: some View {
        if modelData.activeFeed != nil {
            NavigationView {
                VStack {
                    if modelData.jobPosts.count > 0 {
                        List(modelData.jobPosts, selection: $selected) { post in
                            HStack {
                                HighlightText(text: post.title, term: modelData.searchText)
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
                }
                .frame(minWidth: 300)

                if selectedJob == nil {
                    Text("Please select one of jobs")
                } else {
                    JobDetail(post: selectedJob!, searchText: modelData.searchText)
                }
            }
            .frame(minWidth: 1024, minHeight: 860)
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                modelData.search(text: searchText)
            }
        } else {
            Text("")
        }
    }
}

struct JobsContentView_Previews: PreviewProvider {
    static var previews: some View {
        JobsContentView()
            .environmentObject(ModelData.shared)
    }
}
