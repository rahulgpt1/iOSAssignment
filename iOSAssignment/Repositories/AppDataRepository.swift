//
//  AppDataRepository.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 25/09/25.
//

import Foundation

@MainActor
class AppDataRepository: ObservableObject, AppDataRepositoryProtocol {
    @Published private(set) var movies: [Movie] = []
    @Published private(set) var characters: [MovieCharacter] = []
    @Published private(set) var quotes: [MovieDialog] = []
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchAllData() async throws {
        do {
            async let moviesData = apiService.fetchMovies()
            async let charactersData = apiService.fetchCharacters()
            async let quotesData = apiService.fetchQuotes()
            
            let (moviesResponse, charactersResponse, quotesResponse) = try await (moviesData, charactersData, quotesData)
            
            self.movies = moviesResponse.docs
            self.characters = charactersResponse.docs
            self.quotes = quotesResponse.docs
            
        } catch {
           throw error
        }
    }
}
