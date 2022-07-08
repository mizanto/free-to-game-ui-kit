//
//  GameInfoViewModelTests.swift
//  free-to-game-unit-tests
//
//  Created by Sergey Bendak on 08.07.2022.
//

import XCTest
import Combine
@testable import free_to_game_ui_kit

class GameInfoViewModelTests: XCTestCase {
    
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
    func test_GameInfoViewModel_emptyState_whenCreated() {
        // given
        let sut = givenViewModel(client: mockClient)
        let expectation = expectation(description: "Waiting for init state")
        let expectedState: ViewState<GameInfoModel> = .empty(NSLocalizedString("game_info.empty.title", comment: ""))
        var resultState: ViewState<GameInfoModel>? = nil
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
    func test_GameInfoViewModel_showsLoadingState_whenFetchData() {
        let sut = givenViewModel(client: mockClient)
        let expectation = expectation(description: "Waiting for loading state")
        let expectedState: ViewState<GameInfoModel> = .loading(NSLocalizedString("game_info.loading.title", comment: ""))
        var resultState: ViewState<GameInfoModel>? = nil
        
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
        let sut = givenViewModel(client: mockClient)
        let expectation = expectation(description: "Waiting for error state")
        let expectedState: ViewState<GameInfoModel> = .error(expectedError.errorDescription!)
        var resultState: ViewState<GameInfoModel>? = nil
        
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
    
    func test_GameInfoViewModel_showsUnknownErrorState_whenFetchDataReceiveUnknownError() {
        let expectedError = UnknownError.error
        mockClient.error = expectedError
        let sut = givenViewModel(client: mockClient)
        let expectation = expectation(description: "Waiting for error state")
        let expectedState: ViewState<GameInfoModel> = .error(NSLocalizedString("error.unknown", comment: ""))
        var resultState: ViewState<GameInfoModel>? = nil
        
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
    
    func test_GameInfoViewModel_showsContentState_whenFetchDataReceiveValidData() {
        let sut = givenViewModel(client: mockClient)
        let expectation = expectation(description: "Waiting for content state")
        let expectedState: ViewState<GameInfoModel> = .content(MockClient.validGameInfoModel)
        var resultState: ViewState<GameInfoModel>? = nil
        
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
    func test_GameInfoViewModel_showsLoadingState_whenRetry() {
        let sut = givenViewModel(client: mockClient)
        let expectation = expectation(description: "Waiting for loading state")
        let expectedState: ViewState<GameInfoModel> = .loading(NSLocalizedString("game_info.loading.title", comment: ""))
        var resultState: ViewState<GameInfoModel>? = nil
        
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
    
    func test_GameInfoViewModel_showsErrorState_whenRetryReceiveNetworkError() {
        let expectedError = NetworkError.unavailable
        mockClient.error = expectedError
        let sut = givenViewModel(client: mockClient)
        let expectation = expectation(description: "Waiting for error state")
        let expectedState: ViewState<GameInfoModel> = .error(expectedError.errorDescription!)
        var resultState: ViewState<GameInfoModel>? = nil
        
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
    
    func test_GameInfoViewModel_showsValueState_whenRetryReceiveValidData() {
        let sut = givenViewModel(client: mockClient)
        let expectation = expectation(description: "Waiting for value state")
        let expectedState: ViewState<GameInfoModel> = .content(MockClient.validGameInfoModel)
        var resultState: ViewState<GameInfoModel>? = nil
        
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
    
    // MARK: - onPlayNow
    func test_GameInfoViewModel_callsOnShowWeb_whenPlayNowPressed() {
        let expectation = expectation(description: "Waiting for play now tap")
        let sut = givenViewModel(client: mockClient) { _ in
            expectation.fulfill()
        }
        
        sut.statePublisher
            .dropFirst() // drop init state
            .sink(receiveValue: { state in
                if state.isContent {
                    sut.sendEvent(.playNowPressed)
                }
            })
            .store(in: &subscriptions)
        sut.sendEvent(.fetchData)
        
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - Helpers
    private func givenViewModel(title: String? = nil, client: Client, gameId: Int = 0, onShowWeb: @escaping (URL) -> () = { _ in }) -> GameInfoViewModel {
        return GameInfoViewModel(title: title, client: client, gameId: gameId, onShowWeb: onShowWeb)
    }
}
