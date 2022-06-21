//
//  ExtendedGameModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation

struct ExtendedGameModel: Codable, Identifiable, CustomStringConvertible {
    let id: Int
    let title: String
    let thumbnail: URL
    let fullDescription: String
    let url: URL
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let systemRequirements: SystemRequirementsModel?
    let screenshots: [ScreenshotModel]
    
    var description: String {
        return "\n\nid: \(id)"
        + "\ntitle: \(title)"
        + "\nthumbnail: \(thumbnail)"
        + "\ndescription: \(fullDescription)"
        + "\ngenre: \(genre)"
        + "\nplatform: \(platform)"
        + "\npublisher: \(publisher)"
        + "\ndeveloper: \(developer)"
        + "\nreleaseDate: \(releaseDate)"
        + "\nsystemRequirements: \(String(describing: systemRequirements))"
        + "\nscreenshots: \(screenshots)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case fullDescription = "description"
        case url = "game_url"
        case genre
        case platform
        case publisher
        case developer
        case releaseDate = "release_date"
        case systemRequirements = "minimum_system_requirements"
        case screenshots
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        let thumbnailStr = try values.decode(String.self, forKey: .thumbnail)
        thumbnail = URL(string: thumbnailStr)!
        fullDescription = try values.decode(String.self, forKey: .fullDescription)
        let gameUrl = try values.decode(String.self, forKey: .url)
        url = URL(string: gameUrl)!
        genre = try values.decode(String.self, forKey: .genre)
        platform = try values.decode(String.self, forKey: .platform)
        publisher = try values.decode(String.self, forKey: .publisher)
        developer = try values.decode(String.self, forKey: .developer)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        systemRequirements = try? values.decode(SystemRequirementsModel.self, forKey: .systemRequirements)
        screenshots = try values.decode([ScreenshotModel].self, forKey: .screenshots)
    }
    
    init(id: Int,
         title: String,
         thumbnail: URL,
         fullDescription: String,
         url: URL,
         genre: String,
         platform: String,
         publisher: String,
         developer: String,
         releaseDate: String,
         systemRequirements: SystemRequirementsModel,
         screenshots: [ScreenshotModel]) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.fullDescription = fullDescription
        self.url = url
        self.genre = genre
        self.platform = platform
        self.publisher = publisher
        self.developer = developer
        self.releaseDate = releaseDate
        self.systemRequirements = systemRequirements
        self.screenshots = screenshots
    }
}
