//
//  ModelData.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import Foundation

final class ModelData: ObservableObject {
    static var shared = ModelData()
    
    @Published var sideMenuItems = [
        SideMenuItem(id: 1, text: "Add a feed", icon: "plus", displayOrder: 100, group: 1),
        SideMenuItem(id: 2, text: "Preference", icon: "slider.horizontal.3", displayOrder: 0, group: 2)
    ]
    @Published var _activeFeedId: Int?
    @Published var jobPosts: [JobPost] = []
    
    var activeFeedId: Int? {
        get {
            return _activeFeedId
        }
        set(value) {
            _activeFeedId = value
            getData()
        }
    }
    
    var feeds: [Feed] = []
    var globalSettings = GlobalSettings.shared
    var pagination = Pagination()
    
    init () {
        sideMenuItems.append(SideMenuItem(id: 3, text: "All jobs", icon: "dot.radiowaves.right", displayOrder: 0, group: 0))
        feeds.append(Feed(id: 3))
        activeFeedId = 3
        
        getData()
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            self.getData(true)
        }
    }
    
    var activeFeed: Feed? {
        feeds.first(where: { $0.id == activeFeedId })
    }
    
    var totalPage: Int {
        Int(ceil(Double(pagination.total) / Double(pagination.limit)))
    }
    
    var page: Int {
        get {
            return pagination.page
        }
        
        set(value) {
            if value > totalPage {
                pagination.page = totalPage
            } else if value < 1 {
                pagination.page = 1
            } else {
                pagination.page = value
                getData()
            }
        }
    }
    
    var limit: Int {
        get {
            return pagination.limit
        }
        
        set(value) {
            pagination.limit = value
            pagination.page = 1
            UserDefaults.standard.set(pagination.limit, forKey: "limit")
            getData()
        }
    }
    
    var searchText = ""
    func search(text: String) {
        searchText = text
        getData()
    }
    
    func createFeed(name: String, usOnly: Bool, andText: String, orText: String, jobType: Int, displayOrder: Int) -> Int {
        let id = sideMenuItems.map { item in item.id }.max()! + 1
        
        let feed = Feed(id: id, name: name, usOnly: usOnly, jobType: jobType, andText: andText, orText: orText)
        
        sideMenuItems.append(SideMenuItem(id: id, text: name, icon: "dot.radiowaves.right", displayOrder: displayOrder, group: 0))
        feeds.append(feed)
        
        return id
    }
 
    private func getData (_ isUpdate: Bool = false) {
        guard let activeFeed = activeFeed else {
            return
        }

        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "192.168.0.61"
        urlComponent.port = 3000
        
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
        queryItems.append(URLQueryItem(name: "page", value: String(pagination.page)))

        if activeFeed.usOnly == true {
            queryItems.append(URLQueryItem(name: "usOnly", value: "true"))
        }
        
        if !searchText.isEmpty {
            queryItems.append(URLQueryItem(name: "searchTerm", value: searchText))
        }
        
        if !activeFeed.andText.isEmpty {
            queryItems.append(URLQueryItem(name: "andText", value: activeFeed.andText))
        }

        if !activeFeed.orText.isEmpty {
            queryItems.append(URLQueryItem(name: "orText", value: activeFeed.orText))
        }
        
        if activeFeed.jobType != 0 {
            queryItems.append(URLQueryItem(name: "jobType", value: String(activeFeed.jobType)))
        }

        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            return
        }
        
        NetworkManager.loadData(url: url) { result in
            guard let result = result else {
                return
            }
            
            self.pagination.total = Int(result.total)!
            
            if self.jobPosts.count == 0 {
                self.jobPosts = result.jobs
                return
            }

            if isUpdate {
                let newJobs = result.jobs.filter { $0.timestamp > self.jobPosts.first!.timestamp }
                if newJobs.count > 0 && GlobalSettings.shared.notification == true {
                    NotificationManager.triggerNotification(newJobCount: newJobs.count)
                }
            }

            self.jobPosts = result.jobs
        }
    }
}

struct Pagination {
    var searchTerm = ""
    var total = 0
    var page = 1
    var limit = 40
}
