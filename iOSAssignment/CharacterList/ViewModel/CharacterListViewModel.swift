//
//  CharacterListViewModel.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 24/09/25.
//

import SwiftUI

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characters: [MovieCharacter] = []
    @Published var isLoaded = false
    let repository: AppDataRepositoryProtocol
    private var allCharacters: [MovieCharacter] = []
    private let pageSize = 10
    private var currentPage = 0  
    private var totalPages = 0
    
    init(repository: AppDataRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadCharacters(for movie: Movie) {
        guard !self.isLoaded else { return }
        // 🔹 Step 1: filter all characters for this movie
        let allQuotes = repository.quotes
        let movieQuotes = allQuotes.filter { $0.movieId == movie.id }
        let characterIds = Set(movieQuotes.map { $0.characterId })
        
        self.allCharacters = repository.characters.filter { characterIds.contains($0.id) }
        
        // 🔹 Step 2: reset pagination
        self.currentPage = 0
        self.characters.removeAll()
        
        self.totalPages = Int(ceil(Double(allCharacters.count) / Double(pageSize)))
        self.isLoaded = true
        
        // load first page
        loadNextPage()
    }
    
    func loadNextPage() {
        guard self.currentPage < self.totalPages else { return }
        
        let startIndex = self.currentPage * self.pageSize
        let endIndex = min(startIndex + self.pageSize, self.allCharacters.count)
        
        if startIndex < endIndex {
            let pageSlice = self.allCharacters[startIndex..<endIndex]
            self.characters.append(contentsOf: pageSlice)
            self.currentPage += 1
        }
    }
    
    var hasMorePages: Bool {
        self.currentPage < self.totalPages
    }
}
