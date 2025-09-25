//
//  CharacterListViewModelTests.swift
//  iOSAssignmentUnitTests
//
//  Created by Rahul Gupta on 25/09/25.
//

import XCTest
@testable import iOSAssignment

@MainActor
final class CharacterListViewModelTests: XCTestCase {
    private var mockRepository: MockAppDataRepository!
    private var viewModel: CharacterListViewModel!
    
    override func setUp() {
        super.setUp()
        self.mockRepository = MockAppDataRepository()
        self.viewModel = CharacterListViewModel(repository: self.mockRepository)
    }
    
    override func tearDown() {
        self.mockRepository = nil
        self.viewModel = nil
        super.tearDown()
    }
    
    func testLoadCharacters_LoadsCorrectCharactersForMovie() {
        let movie =  Movie(id: "m1", name: "The Fellowship of the Ring", runtimeInMinutes: 200, budgetInMillions: 300, boxOfficeRevenueInMillions: 300, academyAwardNominations: 25, academyAwardWins: 10, rottenTomatoesScore: 23)
        
        self.mockRepository.characters = [
            MovieCharacter(id: "c1", name: "Frodo", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil),
            MovieCharacter(id: "c2", name: "Aragorn", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil),
            MovieCharacter(id: "c3", name: "Gandalf", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil)
        ]
        
        self.mockRepository.quotes = [
            MovieDialog(dialogId: "d1", dialog: "One ring to rule them all.", movieId: "m1", characterId: "c1", id: "d1"),
            MovieDialog(dialogId: "d2", dialog: "For Frodo.", movieId: "m1", characterId: "c2", id: "d2"),
            MovieDialog(dialogId: "d3", dialog: "Fly, you fools!", movieId: "mm2", characterId: "c3", id: "d3"),
        ]
        
        self.viewModel.loadCharacters(for: movie)
        
        XCTAssertTrue(self.viewModel.isLoaded)
        XCTAssertEqual(self.viewModel.characters.count, 2)
        XCTAssertTrue(self.viewModel.characters.contains(where: { $0.id == "c1" }))
        XCTAssertTrue(self.viewModel.characters.contains(where: { $0.id == "c2" }))
        XCTAssertFalse(self.viewModel.characters.contains(where: { $0.id == "c3" }))
    }
    
    func testLoadCharacters_NoQuotesFound_ShouldResultInEmptyCharacters() {
        // Arrange
        let movie = Movie(id: "m7", name: "Testing Movie", runtimeInMinutes: 30, budgetInMillions: 40, boxOfficeRevenueInMillions: 50, academyAwardNominations: 60, academyAwardWins: 70, rottenTomatoesScore: 80)
    
        self.viewModel.loadCharacters(for: movie)
        
        XCTAssertTrue(self.viewModel.isLoaded)
        XCTAssertTrue(self.viewModel.characters.isEmpty)
        XCTAssertFalse(self.viewModel.hasMorePages)
    }
    
    func testPagination_LoadNextPageAddsMoreCharacters() {
        let movie =  Movie(id: "m1", name: "The Fellowship of the Ring", runtimeInMinutes: 200, budgetInMillions: 300, boxOfficeRevenueInMillions: 300, academyAwardNominations: 25, academyAwardWins: 10, rottenTomatoesScore: 23)
        let quoteCount = 25
        
        // Generate 25 characters and quotes
         let arrCharacter: [MovieCharacter] = (1...quoteCount).map { i in
             MovieCharacter(id: "c\(i)", name: "Char \(i)", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil)
        }
        self.mockRepository.characters = arrCharacter
        
        let arrQuotes: [MovieDialog] =  (1...quoteCount).map { i in
            MovieDialog(dialogId: "d\(i)", dialog: "Dialog \(i)", movieId: "m1", characterId: "c\(i)", id: "d\(i)")
        }
        self.mockRepository.quotes = arrQuotes
        
        self.viewModel.loadCharacters(for: movie)
        
        // Load first page
        XCTAssertEqual(self.viewModel.characters.count, 10)
        XCTAssertTrue(self.viewModel.hasMorePages)
        
        // Load second page
        self.viewModel.loadNextPage()
        XCTAssertEqual(viewModel.characters.count, 20)
        
        // Load third page
        self.viewModel.loadNextPage()
        XCTAssertEqual(self.viewModel.characters.count, 25)
        
        // No more pages
        XCTAssertFalse(self.viewModel.hasMorePages)
        
        // Load next page should do nothing
        self.viewModel.loadNextPage()
        XCTAssertEqual(self.viewModel.characters.count, 25)
    }
}
