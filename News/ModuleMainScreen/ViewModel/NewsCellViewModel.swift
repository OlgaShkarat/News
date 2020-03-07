//
//  NewsCellViewModel.swift
//  News
//
//  Created by Ольга on 06.03.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

protocol NewsCellViewModelProtocol {
    
    var imageViewURL: URL? { get }
    var title: String? { get }
    var description: String? { get }
    var date: Date? { get }
    var url: URL? { get }
}

class NewsCellViewModel: NewsCellViewModelProtocol {

    private var news: News?
    
    var imageViewURL: URL? {
        if let url = news?.urlToImage {
            return URL(string: url)
        }
        return nil
    }
    
    var title: String? {
    
        return news?.title ?? ""
    }
    
    var description: String? {
        return news?.description ?? ""
    }
    
    var date: Date? {
        return news?.publishedAt
     
    }
    
    var url: URL? {
        if let url = news?.url {
            return URL(string: url)
        }
        return nil
    }
    
    init(news: News) {
        self.news = news
    }
}
