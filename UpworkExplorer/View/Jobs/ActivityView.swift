//
//  ActivityView.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/12.
//

import SwiftUI

struct ActivityView: View {
    var post: JobPost

    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            
            Text("Activity on this job")
                .font(.title2)
                .padding(.top)
                .padding(.bottom)
            HStack {
                if post.proposals != nil {
                    VStack {
                        Text(post.proposals!)
                        Text("Proposals").font(.footnote).foregroundColor(.gray)
                    }
                    .padding(.trailing, 20)
                }
                if post.interviewing != nil {
                    VStack {
                        Text(post.interviewing!)
                        Text("Interviewing").font(.footnote).foregroundColor(.gray)
                    }
                    .padding(.trailing, 20)
                }
                if post.invitesSent != nil {
                    VStack {
                        Text(post.invitesSent!)
                        Text("Invites Sent").font(.footnote).foregroundColor(.gray)
                    }
                    .padding(.trailing, 20)
                }
                if post.unanswered != nil {
                    VStack {
                        Text(post.invitesSent!)
                        Text("Unanswered invites").font(.footnote).foregroundColor(.gray)
                    }
                }
            }
        }
        .padding(.bottom)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var modelData = ModelData.shared
    
    static var previews: some View {
        if modelData.jobPosts.count > 0 {
            ActivityView(post: modelData.jobPosts.first!)
        } else {
            Text("Loading...")
        }
    }
}
