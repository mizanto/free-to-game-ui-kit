//
//  StringIdentifiable.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 22.06.2022.
//

import UIKit

protocol StringIdentifiable: AnyObject {
    static var identifier: String { get }
}

extension StringIdentifiable where Self: NSObject {
    
    static var identifier: String {
        return nameOfClass
    }

}

extension UITableViewCell: StringIdentifiable {}
extension UICollectionViewCell: StringIdentifiable {}
extension UITableViewHeaderFooterView: StringIdentifiable {}
