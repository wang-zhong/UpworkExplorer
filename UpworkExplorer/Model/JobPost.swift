//
//  JobPost.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import Foundation

struct JobPost: Identifiable, Hashable, Codable {
    var id: Int
    var time: String
    var timestamp: String
    var href: String
    var title: String
    var jobType: String
    var hoursNeeded: String?
    var duration: String?
    var budget: String?
    var experienceLevel: String
    var description: String
    var badges: String
    var country: String
    var createdAt: String
    var locationRestriction: String?
    var proposals: String?
    var interviewing: String?
    var invitesSent: String?
    var unanswered: String?
    var clientLocation: String?
    var jobPosted: String?
    var hireRate: String?
    var totalSpent: String?
    var hires: String?
    var clientHourlyRate: String?
    var clientHours: String?
    var clientCompanyIndustry: String?
    var clientCompanySize: String?
    var memberSince: String?

    
    var postedAt: String {
        let current = NSDate().timeIntervalSince1970
        let posted = Double(timestamp)! / 1000
        
        let diff = current - posted
        
        switch diff {
        case 0..<60:
            return "\(time) - \(Int(diff)) seconds ago"
        case 60..<3600:
            return "\(time) - \(Int(diff / 60)) minutes ago"
        case 3600 ..< 3600 * 24:
            return "\(time) - \(Int(diff / 3600)) hours ago"
        default:
            return "\(time) - \(Int(diff / 3600 / 24)) days ago"
        }
    }
    
    var location: String {
        locationRestriction ?? country
    }
}
