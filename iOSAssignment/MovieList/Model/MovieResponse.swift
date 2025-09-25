//
//  MovieResponse.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 24/09/25.
//

import Foundation

struct MovieResponse: Codable {
    let docs: [Movie]
    let total: Int
    let limit: Int
    let offset: Int
    let page: Int
    let pages: Int
}

struct Movie: Codable, Identifiable {
    let id: String
    let name: String
    let runtimeInMinutes: Int
    let budgetInMillions: Double
    let boxOfficeRevenueInMillions: Double
    let academyAwardNominations: Int
    let academyAwardWins: Int
    let rottenTomatoesScore: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case runtimeInMinutes
        case budgetInMillions
        case boxOfficeRevenueInMillions
        case academyAwardNominations
        case academyAwardWins
        case rottenTomatoesScore
    }
}
