//
//  CharacterDetailViewModelTests.swift
//  iOSAssignmentUnitTests
//
//  Created by Rahul Gupta on 25/09/25.
//

import XCTest
@testable import iOSAssignment

@MainActor
final class CharacterDetailViewModelTests: XCTestCase {
    
    func testLoadQuotes_FiltersCorrectlyForCharacter() {
        let movieCharacter = MovieCharacter(id: "c1", name: "Gandalf", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil)
        let movieDialog1 = MovieDialog(dialogId: "d1", dialog: "You shall not pass!", movieId: "m1", characterId: "c1", id: "d1")
        let movieDialog2 = MovieDialog(dialogId: "d2", dialog: "Fly, you fools!", movieId: "m1", characterId: "c1", id: "d1")
        let movieDialog3 = MovieDialog(dialogId: "d3", dialog: "I'm Sam", movieId: "m1", characterId: "c2", id: "d1")
        
        let mockRepository = MockAppDataRepository()
        mockRepository.quotes = [movieDialog1, movieDialog2, movieDialog3]
        
        let viewModel = CharacterDetailViewModel(character: movieCharacter, repository: mockRepository)
        
        XCTAssertEqual(viewModel.quotes.count, 2)
        XCTAssertTrue(viewModel.quotes.contains(where: { $0.dialog == "You shall not pass!" }))
        XCTAssertFalse(viewModel.quotes.contains(where: { $0.characterId == "c2" }))
    }
    
    func testLoadQuotes_WithNoMatchingQuotes_ShouldBeEmpty() {
        let character = MovieCharacter(id: "c1", name: "Gandalf", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil)
        let quote =  MovieDialog(dialogId: "d1", dialog: "You shall not pass!", movieId: "m1", characterId: "c2", id: "d1")
        
        let mockRepository = MockAppDataRepository()
        mockRepository.quotes = [quote]
        
        let viewModel = CharacterDetailViewModel(character: character, repository: mockRepository)
        
        XCTAssertTrue(viewModel.quotes.isEmpty)
    }
    
    func testInit_AssignCharacterCorrectly() {
        let character = MovieCharacter(id: "c1", name: "Gandalf", wikiUrl: nil, race: nil, birth: nil, gender: nil, death: nil, hair: nil, height: nil, realm: nil, spouse: nil)
        let mockRepo = MockAppDataRepository()
        
        let viewModel = CharacterDetailViewModel(character: character, repository: mockRepo)
        
        XCTAssertEqual(viewModel.character.name, "Gandalf")
        XCTAssertEqual(viewModel.character.id, "c1")
    }
}
