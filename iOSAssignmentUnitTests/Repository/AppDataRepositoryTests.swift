//
//  AppDataRepositoryTests.swift
//  iOSAssignmentUnitTests
//
//  Created by Rahul Gupta on 25/09/25.
//

import XCTest
@testable import iOSAssignment

@MainActor
final class AppDataRepositoryTests: XCTestCase {
    
    func testFetchAllData_Successful() async throws {
        let mockService = MockAPIService()
        
        mockService.mockMovies = MovieResponse(docs: [ Movie(id: "m1", name: "The Fellowship of the Ring", runtimeInMinutes: 200, budgetInMillions: 300, boxOfficeRevenueInMillions: 300, academyAwardNominations: 25, academyAwardWins: 10, rottenTomatoesScore: 23)], total: 1, limit: 10, offset: 0, page: 1, pages: 1)
        

        mockService.mockCharacters = CharacterResponse(docs: [MovieCharacter(id: "c1", name: "Frodo", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil)], total: 1, limit: 10, offset: 0, page: 1, pages: 1)
        
        mockService.mockQuotes = MovieDialogResponse(docs: [MovieDialog(dialogId: "d1", dialog: "One ring to rule them all.", movieId: "m1", characterId: "c1", id: "d1")], total: 1, limit: 10, offset: 0, page: 1, pages: 1)
        
        let repository = AppDataRepository(apiService: mockService)
        
        try await repository.fetchAllData()
        
        XCTAssertEqual(repository.movies.count, 1)
        XCTAssertEqual(repository.movies.first?.name, "The Fellowship of the Ring")
        
        XCTAssertEqual(repository.characters.count, 1)
        XCTAssertEqual(repository.characters.first?.name, "Frodo")
        
        XCTAssertEqual(repository.quotes.count, 1)
        XCTAssertEqual(repository.quotes.first?.dialog, "One ring to rule them all.")
    }
    
    func testFetchAllData_Failure() async {
        let mockService = MockAPIService()
        mockService.shouldThrowError = true
        
        let repository = AppDataRepository(apiService: mockService)
        
        do {
            try await repository.fetchAllData()
            XCTFail("Expected to throw, but did not")
        } catch {
            XCTAssertTrue(error is URLError)
        }
        
        XCTAssertTrue(repository.movies.isEmpty)
        XCTAssertTrue(repository.characters.isEmpty)
        XCTAssertTrue(repository.quotes.isEmpty)
    }
}
