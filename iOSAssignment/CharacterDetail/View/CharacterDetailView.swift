//
//  CharacterDetailView.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 24/09/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: MovieCharacter
    @StateObject private var viewModel: CharacterDetailViewModel
    
    init(character: MovieCharacter, repository: AppDataRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(character: character, repository: repository))
        self.character = character
    }
    
    var body: some View {
        List {
            Section(header: Text("Character Info")) {
                Text("Name: \(character.name)")
                if let gender = character.gender {
                    Text("Gender: \(gender)")
                }
                if let birth = character.birth {
                    Text("Birth: \(birth)")
                }
            }
            
            if !viewModel.quotes.isEmpty {
                Section(header: Text("Quotes")) {
                    ForEach(viewModel.quotes) { quote in
                        Text(quote.dialog)
                            .padding(.vertical, 4)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(character.name)
    }
}
