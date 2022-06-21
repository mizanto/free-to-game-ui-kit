//
//  ShortGameModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation

struct ShortGameModel: Codable, CustomStringConvertible {
    let id: Int
    let title: String
    let thumbnail: URL
    let shortDescription: String
    let genre: String
    let platform: String
    
    var description: String {
        return "\n\nid: \(id)\n"
        + "title: \(title)"
        + "\nthumbnail: \(thumbnail)"
        + "\nshortDescription: \(shortDescription)"
        + "\ngenre: \(genre)"
        + "\nplatform: \(platform)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case shortDescription = "short_description"
        case genre
        case platform
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        let thumbnailStr = try values.decode(String.self, forKey: .thumbnail)
        thumbnail = URL(string: thumbnailStr)!
        shortDescription = try values.decode(String.self, forKey: .shortDescription)
        genre = try values.decode(String.self, forKey: .genre)
        platform = try values.decode(String.self, forKey: .platform)
    }
    
    init(id: Int, title: String, thumbnail: URL, shortDescription: String, genre: String, platform: String) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.shortDescription = shortDescription
        self.genre = genre
        self.platform = platform
    }
}
