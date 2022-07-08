//
//  ViewState.swift
//  free-to-game-ui-kit
//
//  Created by Sergey Bendak on 08.07.2022.
//

import Foundation

enum ViewState<T: Equatable>: Equatable {
    case content(T)
    case empty(String)
    case loading(String)
    case error(String)
}
