//
//  MockAppDataRepository.swift
//  iOSAssignmentUnitTests
//
//  Created by Rahul Gupta on 25/09/25.
//

import XCTest
@testable import iOSAssignment


class MockAppDataRepository: AppDataRepositoryProtocol {
    var shouldThrowError = false
    
    var movies: [Movie] = []
    var characters: [MovieCharacter] = []
    var quotes: [MovieDialog] = []
    
    func fetchAllData() async throws {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        // Simulated successful fetch
        self.movies = [
            Movie(id: "m1", name: "The Fellowship of the Ring", runtimeInMinutes: 200, budgetInMillions: 300, boxOfficeRevenueInMillions: 300, academyAwardNominations: 25, academyAwardWins: 10, rottenTomatoesScore: 23),
            Movie(id: "m2", name: "The Two Towers", runtimeInMinutes: 200, budgetInMillions: 300, boxOfficeRevenueInMillions: 300, academyAwardNominations: 25, academyAwardWins: 10, rottenTomatoesScore: 23),
        ]
        
        self.characters = [
            MovieCharacter(id: "c1", name: "Frodo", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil),
            MovieCharacter(id: "c2", name: "Aragorn", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil),
            MovieCharacter(id: "c3", name: "Gandalf", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil)
        ]
        
        self.quotes = [
            MovieDialog(dialogId: "d1", dialog: "One ring to rule them all.", movieId: "m1", characterId: "c1", id: "d1"),
            MovieDialog(dialogId: "d2", dialog: "For Frodo.", movieId: "m1", characterId: "c2", id: "d2"),
            MovieDialog(dialogId: "d3", dialog: "Fly, you fools!", movieId: "mm2", characterId: "c3", id: "d3"),
        ]
    }
}
