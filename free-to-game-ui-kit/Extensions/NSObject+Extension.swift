//
//  NSObject+Extension.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 22.06.2022.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
