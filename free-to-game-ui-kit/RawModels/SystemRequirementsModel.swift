//
//  SystemRequirementsModel.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 21.06.2022.
//

import Foundation

struct SystemRequirementsModel: Codable, CustomStringConvertible {
    let os: String
    let processor: String
    let memory: String
    let graphics: String
    let storage: String
    
    var description: String {
        return "\n  os: \(os)"
        + "\n  processor: \(processor)"
        + "\n  memory: \(memory)"
        + "\n  graphics: \(graphics)"
        + "\n  storage: \(storage)"
    }
}
