//
//  CharacterDetailViewModel.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 24/09/25.
//

import SwiftUI

@MainActor
class CharacterDetailViewModel: ObservableObject {
    @Published var quotes: [MovieDialog] = []
    let character: MovieCharacter
    let repository: AppDataRepositoryProtocol
    
    init(character: MovieCharacter, repository: AppDataRepositoryProtocol) {
        self.character = character
        self.repository = repository
        self.loadQuotes()
    }
    
    private func loadQuotes() {
        self.quotes = repository.quotes.filter { $0.characterId == character.id }
    }
}
