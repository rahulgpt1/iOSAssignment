//
//  MockAPIService.swift
//  iOSAssignmentUnitTests
//
//  Created by Rahul Gupta on 25/09/25.
//

import XCTest
@testable import iOSAssignment

final class MockAPIService: APIServiceProtocol {
    var shouldThrowError = false
    
    var mockMovies: MovieResponse = MovieResponse(docs: [], total: 0, limit: 0, offset: 0, page: 0, pages: 0)
    var mockCharacters: CharacterResponse = CharacterResponse(docs: [], total: 0, limit: 0, offset: 0, page: 0, pages: 0)
    var mockQuotes: MovieDialogResponse = MovieDialogResponse(docs: [], total: 0, limit: 0, offset: 0, page: 0, pages: 0)
    
    func fetchMovies() async throws -> MovieResponse {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return mockMovies
    }
    
    func fetchCharacters() async throws -> CharacterResponse {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return mockCharacters
    }
    
    func fetchQuotes() async throws -> MovieDialogResponse {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return mockQuotes
    }
}
