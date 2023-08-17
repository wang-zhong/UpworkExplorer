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
            settings.page = 1
            UserDefaults.standard.set(settings.usOnly, forKey: "usOnly")
            getData()
        }
    }
    
    var searchTerm: String {
        get {
            return settings.searchTerm
        }
        
        set(value) {
            settings.searchTerm = value
            settings.page = 1
            UserDefaults.standard.set(settings.searchTerm, forKey: "searchTerm")
            getData()
        }
    }
    
    var preferNotification: Bool {
        get {
            return settings.preferNotification
        }
        
        set(value) {
            settings.preferNotification = value
            UserDefaults.standard.set(settings.preferNotification, forKey: "notification")
        }
    }
    
    var total: Int {
        get {
            return settings.total
        }
        
        set(value) {
            settings.total = value
        }
    }
    
    var totalPage: Int {
        Int(ceil(Double(settings.total) / Double(settings.limit)))
    }
    
    var page: Int {
        get {
            return settings.page
        }
        
        set(value) {
            if value > totalPage {
                settings.page = totalPage
            } else if value < 1 {
                settings.page = 1
            } else {
                settings.page = value
                getData()
            }
        }
    }
    
    var limit: Int {
        get {
            return settings.limit
        }
        
        set(value) {
            settings.limit = value
            settings.page = 1
            UserDefaults.standard.set(settings.limit, forKey: "limit")
            getData()
        }
    }
    
    init() {
        getData()
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            self.getData(true)
        }
    }
    
    private func getData (_ isUpdate: Bool = false) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "192.168.0.152"
        urlComponent.port = 3000
        
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
        queryItems.append(URLQueryItem(name: "page", value: String(page)))

        if jobPosts.count > 0 {
            queryItems.append(URLQueryItem(name: "relativeTime", value: jobPosts.first!.createdAt))
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
        
        NetworkManager.loadData(url: url) { result in
            guard let result = result else {
                return
            }
            
            self.total = Int(result.total)!
            
            if self.jobPosts.count == 0 {
                self.jobPosts = result.jobs
                return
            }

            if isUpdate {
                let newJobs = result.jobs.filter { $0.timestamp > self.jobPosts.first!.timestamp }
                if newJobs.count > 0 && self.settings.preferNotification == true {
                    NotificationManager.triggerNotification(newJobCount: newJobs.count)
                }
            }

            self.jobPosts = result.jobs
        }
    }
}
