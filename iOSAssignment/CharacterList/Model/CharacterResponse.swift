//
//  CharacterResponse.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 24/09/25.
//

import Foundation

struct CharacterResponse: Codable {
    let docs: [MovieCharacter]
    let total: Int
    let limit: Int
    let offset: Int
    let page: Int
    let pages: Int
}

struct MovieCharacter: Codable, Identifiable {
    let id: String
    let name: String
    let wikiUrl: String?
    let race: String?
    let birth: String?
    let gender: String?
    let death: String?
    let hair: String?
    let height: String?
    let realm: String?
    let spouse: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case wikiUrl
        case race
        case birth
        case gender
        case death
        case hair
        case height
        case realm
        case spouse
    }
}

