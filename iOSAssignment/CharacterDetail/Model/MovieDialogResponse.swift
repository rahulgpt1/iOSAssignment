//
//  MovieDialogResponse.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 24/09/25.
//

import Foundation

struct MovieDialogResponse: Codable {
    let docs: [MovieDialog]
    let total: Int
    let limit: Int
    let offset: Int
    let page: Int
    let pages: Int
}

struct MovieDialog: Codable, Identifiable {
    let dialogId: String
    let dialog: String
    let movieId: String
    let characterId: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case dialogId = "_id"
        case dialog
        case movieId = "movie"
        case characterId = "character"
        case id
    }
}

