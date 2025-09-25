//
//  MovieListView.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 24/09/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel: MovieListViewModel
    
    init(repository: AppDataRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: MovieListViewModel(repository: repository))
    }
    
    var body: some View {
        NavigationView {
            self.content
                .navigationTitle("Movies")
        }
        .onAppear {
            Task {
                await self.viewModel.fetchData()
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if self.viewModel.isLoading {
            self.loadingView
        } else if let error = self.viewModel.errorMessage {
            self.errorView(error)
        } else {
            self.movieListView
        }
    }
    
    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView("Loading movies...")
                .progressViewStyle(CircularProgressViewStyle())
            Spacer()
        }
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.orange)
            
            Text(message)
                .multilineTextAlignment(.center)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .padding()
    }
    
    private var movieListView: some View {
        List(self.viewModel.movies) { movie in
            NavigationLink(destination: CharacterListView(movie: movie, repository: self.viewModel.repository)) {
                HStack {
                    Text(movie.name)
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(10)
                    
                    Spacer()
                    
                    //Heart image with fill shows favourite movie
                    Button(action: {
                        viewModel.toggleFavorite(movie)
                    }) {
                        Image(systemName: viewModel.isFavorite(movie) ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.isFavorite(movie) ? .red : .gray)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
