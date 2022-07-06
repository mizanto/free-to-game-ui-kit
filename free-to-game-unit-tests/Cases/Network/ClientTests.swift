//
//  ClientTests.swift
//  free-to-game-unit-tests
//
//  Created by Sergey Bendak on 06.07.2022.
//

import XCTest
@testable import free_to_game_ui_kit

class ClientTests: XCTestCase {
    func test_Client_notThrowsError_whenSuccess() async {
        let sut = givenClient()

        XCTAssertNoThrow(
            Task(priority: .medium, operation: {
                try await sut.sendRequest(endpoint: .games)
            })
        )
    }
    
    func test_Client_throwsBadRequest_when400Error() async {
        // given
        let sut = givenClient(statusCode: 400)
        let expectedError = NetworkError.badRequest
        
        await XCTAssertThrowsError(
            // when
            try await sut.sendRequest(endpoint: .games),
            errorHandler: { error in
                // then
                if let error = error as? NetworkError {
                    XCTAssertEqual(error, expectedError)
                } else {
                    XCTFail()
                }
            }
        )
    }
    
    func test_Client_throwsForbiden_when403Error() async {
        // given
        let sut = givenClient(statusCode: 403)
        let expectedError = NetworkError.forbiden
        
        await XCTAssertThrowsError(
            // when
            try await sut.sendRequest(endpoint: .games),
            errorHandler: { error in
                // then
                if let error = error as? NetworkError {
                    XCTAssertEqual(error, expectedError)
                } else {
                    XCTFail()
                }
            }
        )
    }
    
    func test_Client_throwsNotFound_when404Error() async {
        // given
        let sut = givenClient(statusCode: 404)
        let expectedError = NetworkError.notFound
        
        await XCTAssertThrowsError(
            // when
            try await sut.sendRequest(endpoint: .games),
            errorHandler: { error in
                // then
                if let error = error as? NetworkError {
                    XCTAssertEqual(error, expectedError)
                } else {
                    XCTFail()
                }
            }
        )
    }
    
    func test_Client_throwsToManyRequests_when429Error() async {
        // given
        let sut = givenClient(statusCode: 429)
        let expectedError = NetworkError.toManyRequests
        
        await XCTAssertThrowsError(
            // when
            try await sut.sendRequest(endpoint: .games),
            errorHandler: { error in
                // then
                if let error = error as? NetworkError {
                    XCTAssertEqual(error, expectedError)
                } else {
                    XCTFail()
                }
            }
        )
    }
    
    func test_Client_throwsUnavailable_when503Error() async {
        // given
        let sut = givenClient(statusCode: 503)
        let expectedError = NetworkError.unavailable
        
        await XCTAssertThrowsError(
            // when
            try await sut.sendRequest(endpoint: .games),
            errorHandler: { error in
                // then
                if let error = error as? NetworkError {
                    XCTAssertEqual(error, expectedError)
                } else {
                    XCTFail()
                }
            }
        )
    }
    
    func test_Client_throwsInternalServerError_when500Error() async {
        // given
        let sut = givenClient(statusCode: 500)
        let expectedError = NetworkError.internalServerError
        
        await XCTAssertThrowsError(
            // when
            try await sut.sendRequest(endpoint: .games),
            errorHandler: { error in
                // then
                if let error = error as? NetworkError {
                    XCTAssertEqual(error, expectedError)
                } else {
                    XCTFail()
                }
            }
        )
    }
    
    func test_Client_throwsUnknown_whenUnsupportedError() async {
        // given
        let code = 999
        let sut = givenClient(statusCode: code)
        let expectedError = NetworkError.unknown(code)
        
        await XCTAssertThrowsError(
            // when
            try await sut.sendRequest(endpoint: .games),
            errorHandler: { error in
                // then
                if let error = error as? NetworkError {
                    XCTAssertEqual(error, expectedError)
                } else {
                    XCTFail()
                }
            }
        )
    }
    
    func test_Client_throwsParsing_whenInvalidGamesJson() async {
        // given
        guard let data = loadJson(name: "invalid_games") else {
            XCTFail("Unable to load data from a json file")
            return
        }
        let sut = givenClient(data: data)
        let expectedError = NetworkError.parsing
        
        do {
            // when
            let _: [ShortGameModel] = try await sut.get(endpoint: .games)
            XCTFail("Must be thrown parsing error")
        } catch {
            // then
            if let error = error as? NetworkError {
                XCTAssertEqual(error, expectedError)
            } else {
                XCTFail("Thrown unknown error")
            }
        }
    }
    
    func test_Client_parsesCorrectly_whenValidGamesJson() async {
        // given
        guard let data = loadJson(name: "valid_games") else {
            XCTFail("Unable to load data from a json file")
            return
        }
        let sut = givenClient(data: data)
        var models: [ShortGameModel] = []
        // when
        do {
            models = try await sut.get(endpoint: .games)
        } catch {
            XCTFail("Must be parsed correctly")
        }
        // then
        XCTAssertTrue(models.count > 0)
    }
    
    func test_Client_throwsParsing_whenInvalidGameInfoJson() async {
        // given
        guard let data = loadJson(name: "invalid_game_info") else {
            XCTFail("Unable to load data from a json file")
            return
        }
        let sut = givenClient(data: data)
        let expectedError = NetworkError.parsing
        
        do {
            // when
            let _: [ShortGameModel] = try await sut.get(endpoint: .game(1))
            XCTFail("Must be thrown parsing error")
        } catch {
            // then
            if let error = error as? NetworkError {
                XCTAssertEqual(error, expectedError)
            } else {
                XCTFail("Thrown unknown error")
            }
        }
    }
    
    func test_Client_parsesCorrectly_whenValidGameInfoJson() async {
        // given
        guard let data = loadJson(name: "valid_game_info") else {
            XCTFail("Unable to load data from a json file")
            return
        }
        let sut = givenClient(data: data)
        var model: ExtendedGameModel?
        // when
        do {
            model = try await sut.get(endpoint: .game(1))
        } catch {
            XCTFail("Must be parsed correctly")
        }
        // then
        XCTAssertNotNil(model)
    }
    
    // MARK: - Given
    private func givenClient(data: Data = Data(), statusCode: Int = 200) -> NetworkClient {
        return NetworkClient(
            session: MockSession(
                data: data,
                response: HTTPURLResponse.fakeResponse(code: statusCode)
            )
        )
    }
    
    // MARK: - Helpers
    private func loadJson(name: String) -> Data? {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: name, ofType: "json") else {
            return nil
        }
        let fileUrl = URL(fileURLWithPath: filePath)
        return try? Data(contentsOf: fileUrl)
    }
}
