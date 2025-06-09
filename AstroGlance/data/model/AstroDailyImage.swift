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

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case title, url
    }
}
