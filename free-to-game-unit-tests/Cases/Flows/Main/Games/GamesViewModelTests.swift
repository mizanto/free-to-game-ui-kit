//
//  GamesViewModelTests.swift
//  free-to-game-unit-tests
//
//  Created by Sergey Bendak on 06.07.2022.
//

import XCTest
import Combine
@testable import free_to_game_ui_kit

class GamesViewModelTests: XCTestCase {
    
    var mockClient: MockClient!
    var subscriptions: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockClient = MockClient()
        subscriptions = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        subscriptions = []
        mockClient = nil
        try super.tearDownWithError()
    }
    
    func test_GamesViewModel_emptyState_whenCreated() {
        // given
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for init state")
        let expectedState: Games.State = .empty(NSLocalizedString("games.empty.title", comment: ""))
        var resultState: Games.State? = nil
        // when
        sut.statePublisher.sink { state in
            resultState = state
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        // then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }
    
    func test_GamesViewModel_showsLoadingState_whenFetchData() {
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for loading state")
        let expectedState: Games.State = .loading(NSLocalizedString("games.loading.title", comment: ""))
        var resultState: Games.State? = nil
        
        sut.statePublisher
            .dropFirst() // drop init state
            .filter { $0.isLoading }
            .sink(receiveValue: { state in
                resultState = state
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        sut.sendEvent(.fetchData)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }
    
    func test_GamesViewModel_showsErrorState_whenFetchDataReceiveNetworkError() {
        let expectedError = NetworkError.unavailable
        mockClient.error = expectedError
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for error state")
        let expectedState: Games.State = .error(expectedError.errorDescription!)
        var resultState: Games.State? = nil
        
        sut.statePublisher
            .dropFirst() // drop init state
            .filter { $0.isError }
            .sink(receiveValue: { state in
                resultState = state
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        sut.sendEvent(.fetchData)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }
    
    func test_GamesViewModel_showsUnknownErrorState_whenFetchDataReceiveUnknownError() {
        let expectedError = UnknownError.error
        mockClient.error = expectedError
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for error state")
        let expectedState: Games.State = .error(NSLocalizedString("error.unknown", comment: ""))
        var resultState: Games.State? = nil
        
        sut.statePublisher
            .dropFirst() // drop init state
            .filter { $0.isError }
            .sink(receiveValue: { state in
                resultState = state
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        sut.sendEvent(.fetchData)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }
    
    func test_GamesViewModel_showsEmptyState_whenFetchDataReceiveEmptyResponse() {
        mockClient.games = []
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for empty state")
        let expectedState: Games.State = .empty(NSLocalizedString("games.empty.title", comment: ""))
        var resultState: Games.State? = nil
        
        sut.statePublisher
            .dropFirst() // drop init state
            .filter { $0.isEmpty }
            .sink(receiveValue: { state in
                resultState = state
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        sut.sendEvent(.fetchData)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }
    
    func test_GamesViewModel_showsValueState_whenFetchDataReceiveValidData() {
        mockClient.games = MockClient.validGames
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for value state")
        let expectedState: Games.State = .value(models: MockClient.validCellModels, update: true)
        var resultState: Games.State? = nil
        
        sut.statePublisher
            .dropFirst() // drop init state
            .filter { $0.isValue }
            .sink(receiveValue: { state in
                resultState = state
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        sut.sendEvent(.fetchData)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }

    func test_GamesViewModel_showsLoadingState_whenRetry() {
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for loading state")
        let expectedState: Games.State = .loading(NSLocalizedString("games.loading.title", comment: ""))
        var resultState: Games.State? = nil
        
        sut.statePublisher
            .dropFirst() // drop init state
            .filter { $0.isLoading }
            .sink(receiveValue: { state in
                resultState = state
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        sut.sendEvent(.retry)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }
    
    func test_GamesViewModel_showsErrorState_whenRetryReceiveNetworkError() {
        let expectedError = NetworkError.unavailable
        mockClient.error = expectedError
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for error state")
        let expectedState: Games.State = .error(expectedError.errorDescription!)
        var resultState: Games.State? = nil
        
        sut.statePublisher
            .dropFirst() // drop init state
            .filter { $0.isError }
            .sink(receiveValue: { state in
                resultState = state
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        sut.sendEvent(.retry)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }
    
    func test_GamesViewModel_showsEmptyState_whenRetryReceiveEmptyResponse() {
        mockClient.games = []
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for empty state")
        let expectedState: Games.State = .empty(NSLocalizedString("games.empty.title", comment: ""))
        var resultState: Games.State? = nil
        
        sut.statePublisher
            .dropFirst() // drop init state
            .filter { $0.isEmpty }
            .sink(receiveValue: { state in
                resultState = state
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        sut.sendEvent(.retry)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }
    
    func test_GamesViewModel_showsValueState_whenRetryReceiveValidData() {
        mockClient.games = MockClient.validGames
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for value state")
        let expectedState: Games.State = .value(models: MockClient.validCellModels, update: true)
        var resultState: Games.State? = nil
        
        sut.statePublisher
            .dropFirst() // drop init state
            .filter { $0.isValue }
            .sink(receiveValue: { state in
                resultState = state
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        sut.sendEvent(.retry)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }
    
    func test_GamesViewModel_callsOnSelect_whenSelectItem() {
        var onSelectPressed = false
        mockClient.games = MockClient.validGames
        let sut = GamesViewModel(
            client: mockClient,
            onSelect: { _, _ in
                onSelectPressed = true
            }
        )
        let expectation = expectation(description: "Waiting for selection")
        
        sut.statePublisher
            .dropFirst() // drop init state
            .sink(receiveValue: { state in
                if case let Games.State.value(_, update) = state {
                    if update {
                        sut.sendEvent(.selectRow(0))
                    } else {
                        expectation.fulfill()
                    }
                }
            })
            .store(in: &subscriptions)
        sut.sendEvent(.fetchData)
        
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(onSelectPressed)
    }
    
    func test_GamesViewModel_doesntCallOnSelect_whenEmptyResults() {
        var onSelectPressed = false
        let sut = GamesViewModel(
            client: mockClient,
            onSelect: { _, _ in
                onSelectPressed = true
            }
        )
        let expectation = expectation(description: "Waiting for selection")
        expectation.isInverted = true
        
        sut.statePublisher
            .dropFirst() // drop init state
            .sink(receiveValue: { state in
                if case let Games.State.value(_, update) = state {
                    if update {
                        sut.sendEvent(.selectRow(0))
                    } else {
                        expectation.fulfill()
                    }
                }
            })
            .store(in: &subscriptions)
        sut.sendEvent(.fetchData)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(onSelectPressed)
    }
}
