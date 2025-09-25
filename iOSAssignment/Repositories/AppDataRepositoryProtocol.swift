//
//  AppDataRepositoryProtocol.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 25/09/25.
//

import Foundation

@MainActor
protocol AppDataRepositoryProtocol {
    var movies: [Movie] { get }
    var characters: [MovieCharacter] { get }
    var quotes: [MovieDialog] { get }

    func fetchAllData() async throws
}
