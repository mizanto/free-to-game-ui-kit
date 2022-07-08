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
    
    // MARK: - Init
    func test_GamesViewModel_emptyState_whenCreated() {
        // given
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for init state")
        let expectedState: ViewState<[GameCellModel]> = .empty(NSLocalizedString("games.empty.title", comment: ""))
        var resultState: ViewState<[GameCellModel]>? = nil
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
    
    // MARK: - FetchData
    func test_GamesViewModel_showsLoadingState_whenFetchData() {
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for loading state")
        let expectedState: ViewState<[GameCellModel]> = .loading(NSLocalizedString("games.loading.title", comment: ""))
        var resultState: ViewState<[GameCellModel]>? = nil
        
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
        let expectedState: ViewState<[GameCellModel]> = .error(expectedError.errorDescription!)
        var resultState: ViewState<[GameCellModel]>? = nil
        
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
        let expectedState: ViewState<[GameCellModel]> = .error(NSLocalizedString("error.unknown", comment: ""))
        var resultState: ViewState<[GameCellModel]>? = nil
        
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
        let expectedState: ViewState<[GameCellModel]> = .empty(NSLocalizedString("games.empty.title", comment: ""))
        var resultState: ViewState<[GameCellModel]>? = nil
        
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
    
    func test_GamesViewModel_showsContentState_whenFetchDataReceiveValidData() {
        mockClient.games = MockClient.validShortGameModels
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for content state")
        let expectedState: ViewState<[GameCellModel]> = .content(MockClient.validCellModels)
        var resultState: ViewState<[GameCellModel]>? = nil
        
        sut.statePublisher
            .dropFirst() // drop init state
            .filter { $0.isContent }
            .sink(receiveValue: { state in
                resultState = state
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        sut.sendEvent(.fetchData)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }

    // MARK: - Retry
    func test_GamesViewModel_showsLoadingState_whenRetry() {
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for loading state")
        let expectedState: ViewState<[GameCellModel]> = .loading(NSLocalizedString("games.loading.title", comment: ""))
        var resultState: ViewState<[GameCellModel]>? = nil
        
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
        let expectedState: ViewState<[GameCellModel]> = .error(expectedError.errorDescription!)
        var resultState: ViewState<[GameCellModel]>? = nil
        
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
        let expectedState: ViewState<[GameCellModel]> = .empty(NSLocalizedString("games.empty.title", comment: ""))
        var resultState: ViewState<[GameCellModel]>? = nil
        
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
        mockClient.games = MockClient.validShortGameModels
        let sut = GamesViewModel(client: mockClient, onSelect: { _, _ in })
        let expectation = expectation(description: "Waiting for value state")
        let expectedState: ViewState<[GameCellModel]> = .content(MockClient.validCellModels)
        var resultState: ViewState<[GameCellModel]>? = nil
        
        sut.statePublisher
            .dropFirst() // drop init state
            .filter { $0.isContent }
            .sink(receiveValue: { state in
                resultState = state
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        sut.sendEvent(.retry)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(resultState, expectedState)
    }
    
    // MARK: - SelectItem
    func test_GamesViewModel_callsOnSelect_whenSelectItem() {
        let expectation = expectation(description: "Waiting for selection")
        mockClient.games = MockClient.validShortGameModels
        let sut = GamesViewModel(
            client: mockClient,
            onSelect: { _, _ in
                expectation.fulfill()
            }
        )
        
        sut.statePublisher
            .dropFirst() // drop init state
            .sink(receiveValue: { state in
                if state.isContent {
                    sut.sendEvent(.selectRow(0))
                }
            })
            .store(in: &subscriptions)
        sut.sendEvent(.fetchData)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_GamesViewModel_doesntCallOnSelect_whenEmptyResults() {
        let expectation = expectation(description: "Waiting for selection")
        expectation.isInverted = true
        let sut = GamesViewModel(
            client: mockClient,
            onSelect: { _, _ in
                expectation.fulfill()
            }
        )
        
        sut.statePublisher
            .dropFirst() // drop init state
            .sink(receiveValue: { state in
                if state.isContent {
                    sut.sendEvent(.selectRow(0))
                }
            })
            .store(in: &subscriptions)
        sut.sendEvent(.fetchData)
        
        wait(for: [expectation], timeout: 1)
    }
}
