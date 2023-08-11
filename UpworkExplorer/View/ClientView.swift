//
//  ClientView.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/12.
//

import SwiftUI

struct ClientView: View {
    var post: JobPost
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()

            HStack {
                Text("About the client")
                    .font(.title2)
                    .padding(.top)
                    .padding(.bottom)
                if post.memberSince != nil {
                    Text(post.memberSince!)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            HStack {
                if post.clientLocation != nil {
                    VStack(alignment: .leading) {
                        Text(post.clientLocation!)
                        Text("Location").font(.footnote).foregroundColor(.gray)
                    }
                    .padding(.trailing, 20)
                }
                if post.jobPosted != nil {
                    VStack(alignment: .leading) {
                        Text(post.jobPosted!)
                        Text(post.hireRate!).font(.footnote).foregroundColor(.gray)
                    }
                    .padding(.trailing, 20)
                }
                if post.totalSpent != nil {
                    VStack(alignment: .leading) {
                        Text("\(post.totalSpent!) total spending")
                        Text(post.hires!).font(.footnote).foregroundColor(.gray)
                    }
                    .padding(.trailing, 20)
                }
                if post.clientHourlyRate != nil {
                    VStack(alignment: .leading) {
                        Text(post.clientHourlyRate!)
                        Text(post.clientHours!).font(.footnote).foregroundColor(.gray)
                    }
                    .padding(.trailing, 20)
                }
                VStack(alignment: .leading) {
                    if post.clientCompanyIndustry != nil {
                        Text(post.clientCompanyIndustry!)
                    }
                    if post.clientCompanySize != nil {
                        Text(post.clientCompanySize!)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .padding(.bottom)
    }
}

struct ClientView_Previews: PreviewProvider {
    static var modelData = ModelData()
    
    static var previews: some View {
        if modelData.jobPosts.count > 0 {
            ClientView(post: modelData.jobPosts.first!)
        } else {
            Text("Loading...")
        }
    }
}
