//
//  Games+Extension.swift
//  free-to-game-unit-tests
//
//  Created by Sergey Bendak on 07.07.2022.
//

import Foundation
@testable import free_to_game_ui_kit

extension Games.State: Equatable {
    public static func == (lhs: Games.State, rhs: Games.State) -> Bool {
        switch (lhs, rhs) {
        case (let .value(lhsModels, lhsUpdate), let .value(rhsModels, rhsUpdate)):
            return lhsModels == rhsModels && lhsUpdate == rhsUpdate
        case (let .empty(lhsValue), let .empty(rhsValue)):
            return lhsValue == rhsValue
        case (let .loading(lhsValue), let .loading(rhsValue)):
            return lhsValue == rhsValue
        case (let .error(lhsValue), let .error(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
    
    public var isEmpty: Bool {
        if case .empty(_) = self  { return true }
        return false
    }
    
    public var isLoading: Bool {
        if case .loading(_) = self  { return true }
        return false
    }
    
    public var isError: Bool {
        if case .error(_) = self  { return true }
        return false
    }
    
    public var isValue: Bool {
        if case .value(_, _) = self  { return true }
        return false
    }
}
