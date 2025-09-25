//
//  iOSAssignmentApp.swift
//  iOSAssignment
//
//  Created by Rahul Gupta on 24/09/25.
//

import SwiftUI

@main
struct iOSAssignmentApp: App {
    @StateObject var appDataRepository = AppDataRepository(apiService: APIService())
    
    var body: some Scene {
        WindowGroup {
            MovieListView(repository: appDataRepository)
        }
    }
}
