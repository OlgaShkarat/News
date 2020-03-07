//
//  TechnologyNewsModel.swift
//  News
//
//  Created by Ольга on 04.03.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

struct News: Codable {
    
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: Date
}

struct NewsAll: Codable {
    let articles: [News]
}

