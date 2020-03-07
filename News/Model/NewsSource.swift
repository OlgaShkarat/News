//
//  TechnologyNewsSource.swift
//  News
//
//  Created by Ольга on 04.03.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

enum NewsSource: String {
    
    case rbc = "rbc"
    case lenta = "lenta"
    case googleNews = "google-news-ru"
    case rt = "rt"
    
    var title: String {
        
        switch self {
        case .rbc: return "RBC"
        case .lenta: return "Lenta"
        case .googleNews: return "Google"
        case .rt: return "RT"
            
        }
    }
    
    static var allValues: [NewsSource] {
        return [
            .rbc,
            .lenta,
            .googleNews,
            .rt
        ]
    }
}
