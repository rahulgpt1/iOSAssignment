//
//  APIServiceTests.swift
//  iOSAssignmentUnitTests
//
//  Created by Rahul Gupta on 25/09/25.
//

import XCTest
@testable import iOSAssignment

final class APIServiceTests: XCTestCase {
    
    func testFetchMovies_Success() async throws {
        let mockRequest = MockNetworkRequest()
        let expectedMovies = MovieResponse(docs: [ Movie(id: "m1", name: "The Fellowship of the Ring", runtimeInMinutes: 200, budgetInMillions: 300, boxOfficeRevenueInMillions: 300, academyAwardNominations: 25, academyAwardWins: 10, rottenTomatoesScore: 23)], total: 1, limit: 10, offset: 0, page: 1, pages: 1)
        mockRequest.mockResponse = expectedMovies
        
        let apiService = APIService(networkRequest: mockRequest)
        
        let result = try await apiService.fetchMovies()
        
        XCTAssertEqual(mockRequest.calledEndpoint, .movies)
        XCTAssertEqual(result.docs.count, 1)
        XCTAssertEqual(result.docs.first?.name, "The Fellowship of the Ring")
    }
    
    func testFetchCharacters_Success() async throws {
        let mockRequest = MockNetworkRequest()
        let expectedCharacters = CharacterResponse(docs: [MovieCharacter(id: "c1", name: "Frodo", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil)], total: 1, limit: 10, offset: 0, page: 1, pages: 1)
        mockRequest.mockResponse = expectedCharacters
        
        let apiService = APIService(networkRequest: mockRequest)
        let result = try await apiService.fetchCharacters()
        
        XCTAssertEqual(mockRequest.calledEndpoint, .characters)
        XCTAssertEqual(result.docs.count, 1)
        XCTAssertEqual(result.docs.first?.name, "Frodo")
    }
    
    func testFetchQuotes_Success() async throws {
        let mockRequest = MockNetworkRequest()
        let expectedQuotes = MovieDialogResponse(docs: [MovieDialog(dialogId: "d1", dialog: "One ring to rule them all.", movieId: "m1", characterId: "c1", id: "d1")], total: 1, limit: 10, offset: 0, page: 1, pages: 1)
        mockRequest.mockResponse = expectedQuotes
        
        let apiService = APIService(networkRequest: mockRequest)
        let result = try await apiService.fetchQuotes()
        
        XCTAssertEqual(mockRequest.calledEndpoint, .quotes)
        XCTAssertEqual(result.docs.count, 1)
        XCTAssertEqual(result.docs.first?.dialog, "One ring to rule them all.")
    }
    
    func testFetchMovies_ThrowsError() async {
        let mockRequest = MockNetworkRequest()
        mockRequest.shouldThrow = true
        
        let apiService = APIService(networkRequest: mockRequest)
        
        do {
            _ = try await apiService.fetchMovies()
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
