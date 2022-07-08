//
//  ViewState+Extension.swift
//  free-to-game-unit-tests
//
//  Created by Sergey Bendak on 07.07.2022.
//

import Foundation
@testable import free_to_game_ui_kit

extension ViewState {
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
    
    public var isContent: Bool {
        if case .content(_) = self  { return true }
        return false
    }
}
