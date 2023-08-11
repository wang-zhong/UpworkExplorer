//
//  ModelData.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var jobPosts: [JobPost] = []
    private var settings = Settings()
    var isUsOnly: Bool {
        get {
            return settings.usOnly
        }
        
        set(value) {
            settings.usOnly = value
            jobPosts.removeAll()
            getData()
        }
    }
    
    var searchTerm: String {
        get {
            return settings.searchTerm
        }
        
        set(value) {
            settings.searchTerm = value
            jobPosts.removeAll()
            getData()
        }
    }
    
    var preferNotification: Bool {
        get {
            return settings.preferNotification
        }
        
        set(value) {
            settings.preferNotification = value
        }
    }
    
    init() {
        getData()
        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { timer in
            self.getData()
        }
    }
    
    private func getData () {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "192.168.0.152"
        urlComponent.port = 3000
        
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "limit", value: "40"))
        
        if jobPosts.count > 0 {
            queryItems.append(URLQueryItem(name: "createdAt", value: jobPosts.first!.createdAt))
        }
        
        if settings.usOnly == true {
            queryItems.append(URLQueryItem(name: "usOnly", value: "true"))
        }
        
        if !settings.searchTerm.isEmpty {
            queryItems.append(URLQueryItem(name: "searchTerm", value: settings.searchTerm))
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            return
        }
        
        NetworkManager.loadData(url: url) { jobs in
            if let jobs = jobs, jobs.count > 0 {
                if self.jobPosts.count > 0 && self.settings.preferNotification == true {
                    NotificationManager.triggerNotification(newJobCount: jobs.count)
                }
                
                for job in jobs {
                    if !self.jobPosts.contains(where: { $0.id == job.id }) {
                        self.jobPosts.append(job)
                    }
                }
                
                self.jobPosts.sort { $0.timestamp > $1.timestamp }
            }
        }
    }
}
