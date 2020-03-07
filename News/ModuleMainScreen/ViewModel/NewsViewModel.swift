//
//  NewsViewModel.swift
//  News
//
//  Created by Ольга on 06.03.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

protocol NewsViewModelProtocol {
    func numberOfItemsInSection() -> Int
    func cellForItemAtIndexPath(atIndexPath indexPath: IndexPath) -> NewsCellViewModelProtocol
    func didSelectRow(atIndexPath indexPath: IndexPath) -> URL?
    func fetchData(source: NewsSource, completion: @escaping() ->())
}

class NewsViewModel: NewsViewModelProtocol {
    
    var news: [News] = []
    var networkManager = NetworkManager()
        
    func numberOfItemsInSection() -> Int {
        return news.count
    }
    
    func cellForItemAtIndexPath(atIndexPath indexPath: IndexPath) -> NewsCellViewModelProtocol {
        let oneNews = news[indexPath.row]
        return NewsCellViewModel(news: oneNews)
    }
    
    func didSelectRow(atIndexPath indexPath: IndexPath) -> URL? {
        let oneNews = news[indexPath.row]
        return URL(string: oneNews.url)
    }

    func fetchData(source: NewsSource, completion: @escaping() ->()) {
        
        networkManager.fetchNews(source: source, completion: { [weak self] (news) in
            if let news = news {
                self?.news = news.articles
                completion()
            }
        })
    }
}
