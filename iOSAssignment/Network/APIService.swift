//
//  APIService.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 25/09/25.
//

import Foundation

protocol APIServiceProtocol {
    func fetchMovies() async throws -> MovieResponse
    func fetchCharacters() async throws -> CharacterResponse
    func fetchQuotes() async throws -> MovieDialogResponse
}

enum APIEndpoint: String {
    case movies = "/v2/movie"
    case characters = "/v2/character"
    case quotes = "/v2/quote"
}

class APIService: APIServiceProtocol {
    private let networkRequest: NetworkRequestProtocol
    
    init(networkRequest: NetworkRequestProtocol = NetworkRequest()) {
        self.networkRequest = networkRequest
    }
    
    func fetchMovies() async throws -> MovieResponse {
        return try await networkRequest.request(endpoint: .movies)
    }
    
    func fetchCharacters() async throws -> CharacterResponse {
        return try await networkRequest.request(endpoint: .characters)
    }
    
    func fetchQuotes() async throws -> MovieDialogResponse {
        return try await networkRequest.request(endpoint: .quotes)
    }
}
