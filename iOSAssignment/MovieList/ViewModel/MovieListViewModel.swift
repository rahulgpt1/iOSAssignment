//
//  MovieListViewModel.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 24/09/25.
//

import SwiftUI

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var favoriteMovieIDs: Set<String> = []
    
    let repository: AppDataRepositoryProtocol
    
    init(repository: AppDataRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchData() async {
        self.isLoading = true
        self.errorMessage = nil
        do {
            try await self.repository.fetchAllData()
            self.movies = self.repository.movies
        } catch {
            self.errorMessage = "Something went wrong. Please try again later."
            print("Failed to fetch data: \(error)")
        }
        self.isLoading = false
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        self.favoriteMovieIDs.contains(movie.id)
    }
    
    func toggleFavorite(_ movie: Movie) {
        if self.isFavorite(movie) {
            self.favoriteMovieIDs.remove(movie.id)
        } else {
            self.favoriteMovieIDs.insert(movie.id)
        }
    }
}
