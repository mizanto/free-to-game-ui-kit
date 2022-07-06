//
//  NetworkErrorTests.swift
//  free-to-game-unit-tests
//
//  Created by Sergey Bendak on 06.07.2022.
//

import XCTest
@testable import free_to_game_ui_kit

class NetworkErrorTests: XCTestCase {

    func test_NetworkError_codeNil() {
        // given
        let code: Int? = nil
        let expected = NetworkError.unknown(nil)
        // when
        let error = NetworkError(code: code)
        // then
        XCTAssertEqual(error, expected)
    }
    
    func test_NetworkError_code400() {
        // given
        let code = 400
        let expected = NetworkError.badRequest
        // when
        let error = NetworkError(code: code)
        // then
        XCTAssertEqual(error, expected)
    }
    
    func test_NetworkError_code403() {
        // given
        let code = 403
        let expected = NetworkError.forbiden
        // when
        let error = NetworkError(code: code)
        // then
        XCTAssertEqual(error, expected)
    }
    
    func test_NetworkError_code404() {
        // given
        let code = 404
        let expected = NetworkError.notFound
        // when
        let error = NetworkError(code: code)
        // then
        XCTAssertEqual(error, expected)
    }
    
    func test_NetworkError_code429() {
        // given
        let code = 429
        let expected = NetworkError.toManyRequests
        // when
        let error = NetworkError(code: code)
        // then
        XCTAssertEqual(error, expected)
    }
    
    func test_NetworkError_code500() {
        // given
        let code = 500
        let expected = NetworkError.internalServerError
        // when
        let error = NetworkError(code: code)
        // then
        XCTAssertEqual(error, expected)
    }
    
    func test_NetworkError_code503() {
        // given
        let code = 503
        let expected = NetworkError.unavailable
        // when
        let error = NetworkError(code: code)
        // then
        XCTAssertEqual(error, expected)
    }
    
    func test_NetworkError_unsupported() {
        // given
        let supportedCodes: Set<Int> = [400, 403, 404, 429, 500, 503]
        let code = generateUnsupportedCode(supportedCodes: supportedCodes)
        let expected = NetworkError.unknown(code)
        // when
        let error = NetworkError(code: code)
        // then
        XCTAssertEqual(error, expected)
    }
    
    func test_NetworkError_defaultDescription_whenBadRequest() {
        // given
        let expected = givenDefaultErrorMessage()
        // when
        let error = NetworkError.badRequest
        // then
        XCTAssertEqual(error.errorDescription, expected)
    }
    
    func test_NetworkError_defaultDescription_whenNotFound() {
        // given
        let expected = givenDefaultErrorMessage()
        // when
        let error = NetworkError.notFound
        // then
        XCTAssertEqual(error.errorDescription, expected)
    }
    
    func test_NetworkError_defaultDescription_whenInternalServerError() {
        // given
        let expected = givenDefaultErrorMessage()
        // when
        let error = NetworkError.internalServerError
        // then
        XCTAssertEqual(error.errorDescription, expected)
    }
    
    func test_NetworkError_defaultDescription_whenUnavailable() {
        // given
        let expected = givenDefaultErrorMessage()
        // when
        let error = NetworkError.unavailable
        // then
        XCTAssertEqual(error.errorDescription, expected)
    }
    
    func test_NetworkError_defaultDescription_whenParsingError() {
        // given
        let expected = givenDefaultErrorMessage()
        // when
        let error = NetworkError.parsing
        // then
        XCTAssertEqual(error.errorDescription, expected)
    }
    
    func test_NetworkError_vpnDescription_whenForbiden() {
        // given
        let expected = NSLocalizedString("error.network.vpn", comment: "")
        // when
        let error = NetworkError.forbiden
        // then
        XCTAssertEqual(error.errorDescription, expected)
    }
    
    func test_NetworkError_manyRequestsDescription_whenToManyRequests() {
        // given
        let expected = NSLocalizedString("error.network.many_requests", comment: "")
        // when
        let error = NetworkError.toManyRequests
        // then
        XCTAssertEqual(error.errorDescription, expected)
    }
    
    func test_NetworkError_unknownDescription_whenUnknownError() {
        // given
        let expected = NSLocalizedString("error.unknown", comment: "")
        // when
        let error = NetworkError.unknown(nil)
        // then
        XCTAssertEqual(error.errorDescription, expected)
    }
    
    // Given
    private func givenDefaultErrorMessage() -> String {
        return NSLocalizedString("error.network.default", comment: "")
    }
}

extension NetworkErrorTests {
    private func generateUnsupportedCode(supportedCodes: Set<Int>) -> Int {
        guard !supportedCodes.isEmpty else {
            return Int.random(in: 1..<1000)
        }
        
        var randomCode = supportedCodes.randomElement()!
        while supportedCodes.contains(randomCode) {
            randomCode = Int.random(in: 1..<1000)
        }
        return randomCode
    }
}
