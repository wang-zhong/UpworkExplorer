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
}
