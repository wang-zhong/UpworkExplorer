//
//  JobDetail.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import SwiftUI

struct JobDetail: View {
    @EnvironmentObject var modelData: ModelData
    var post: JobPost
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                HStack {
                    HighlightText(text: post.title, term: modelData.searchTerm)
                        .font(.title)
                    if post.isPrivate == "Private" {
                        Image(systemName: "exclamationmark.lock")
                        Text("Private")
                    }
                }
                Text(post.href)
                    .foregroundColor(.blue)
                Text(post.postedAt)
                HStack {
                    Text(post.jobType)
                    if post.jobType.starts(with: "Fixed") {
                        Text(post.budget!)
                    } else {
                        Text(post.duration!)
                        Text(post.hoursNeeded!)
                    }
                }
                .padding(.top, 4)
                HStack {
                    Text(post.experienceLevel)
                    Text(post.location)
                }
                .padding(.bottom, 4)
                Text("Description: ").font(.title2)
                HighlightText(text: post.description, term: modelData.searchTerm)
                HighlightText(text: post.badges, term: modelData.searchTerm)
                    .foregroundColor(.indigo)
                    .padding(.top)
                    .padding(.bottom)

                ActivityView(post: post)
                ClientView(post: post)
            }
            .padding()
            .textSelection(.enabled)
        }
    }
}

struct JobDetail_Previews: PreviewProvider {
    static var modelData = ModelData()
    
    static var previews: some View {
        if modelData.jobPosts.count > 0 {
            JobDetail(post: modelData.jobPosts.first!)
                .frame(minWidth: 644, minHeight: 860)
                .environmentObject(ModelData())
        } else {
            Text("Loading...")
        }
    }
}
