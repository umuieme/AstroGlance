//
//  AstroDailyImage.swift
//  AstroGlance
//
//  Created by Umesh Basnet on 2025-06-09.
//

import Foundation

struct AstroDailyImage: Identifiable, Decodable {
    let id = UUID()
    let copyright: String?
    let date: String
    let explanation: String
    let hdurl: String?
    let mediaType: String
    let title: String
    let url: String?
    let thumbnailUrl: String?

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl, title, url
        case mediaType = "media_type"
        case thumbnailUrl = "thumbnail_url"
    }
    
    var imageUrl: String? {
        if (mediaType == "video"){
            return thumbnailUrl
        }
        return url;
    }
    
    var owner : String? {
        return copyright?.trimmingCharacters(in: CharacterSet(charactersIn: "\n"))
    }

}
