//
//  NetworkRequest.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 25/09/25.
//

import Foundation

protocol NetworkRequestProtocol {
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T
}

class NetworkRequest: NetworkRequestProtocol {
    private let baseURL = "https://e21a086a-4f08-425a-b99c-a9bbe7539a40.mock.pstmn.io"
    
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        guard let url = URL(string: baseURL + endpoint.rawValue) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
