//
//  HTTPURLResponse+Fake.swift
//  free-to-game-unit-tests
//
//  Created by Sergey Bendak on 06.07.2022.
//

import Foundation

extension HTTPURLResponse {
    static func fakeResponse(code: Int) -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "http://fake.com")!, statusCode: code, httpVersion: nil, headerFields: nil)!
    }
}
