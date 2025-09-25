//
//  CharacterListView.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 24/09/25.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel: CharacterListViewModel
    let movie: Movie
    
    init(movie: Movie, repository: AppDataRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: CharacterListViewModel(repository: repository))
        self.movie = movie
    }
    
    var body: some View {
        List {
            movieCharacterContent
        }
        .onAppear {
            if !viewModel.isLoaded {
                viewModel.loadCharacters(for: movie)
            }
        }
        .navigationTitle(movie.name)
    }
    
    // MARK: - List Content
    @ViewBuilder
    private var movieCharacterContent: some View {
        if viewModel.characters.isEmpty && viewModel.isLoaded {
            emptyStateView
        } else {
            ForEach(viewModel.characters) { character in
                CharacterRow(character: character, repository: viewModel.repository)
            }
            
            if viewModel.hasMorePages && viewModel.isLoaded {
                loadMoreButton {
                    viewModel.loadNextPage()
                }
            }
        }
    }
    
    // MARK: - Empty State View
    private var emptyStateView: some View {
        Text("Sorry, no character found for \(movie.name).")
            .foregroundColor(.gray)
            .italic()
            .multilineTextAlignment(.center)
            .padding()
    }
    
    // MARK: - Load More Button
    private func loadMoreButton(action: @escaping () -> Void) -> some View {
        HStack {
            Spacer()
            Button(action: action) {
                Text("Load More")
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }
            Spacer()
        }
    }
}

// MARK: - Character Row
struct CharacterRow: View {
    let character: MovieCharacter
    let repository: AppDataRepositoryProtocol
    
    var body: some View {
        NavigationLink(destination: CharacterDetailView(character: character, repository: repository)) {
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(10)
            }
        }
    }
}

