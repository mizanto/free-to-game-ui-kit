//
//  ScreenshotModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation

struct ScreenshotModel: Identifiable, Codable, CustomStringConvertible {
    let id: Int
    let url: URL
    
    var description: String {
        return "\nid: \(id), URL: \(url)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case url = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        let imagePath = try values.decode(String.self, forKey: .url)
        url = URL(string: imagePath)!
    }
    
    init(id: Int, url: URL) {
        self.id = id
        self.url = url
    }
}
