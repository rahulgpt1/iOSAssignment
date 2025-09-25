//
//  MovieListViewModelTests.swift
//  iOSAssignmentUnitTests
//
//  Created by Rahul Gupta on 25/09/25.
//

import XCTest
@testable import iOSAssignment

@MainActor
final class MovieListViewModelTests: XCTestCase {
    
    private var mockRepository: MockAppDataRepository!
    private var viewModel: MovieListViewModel!
    
    override func setUp() {
        super.setUp()
        self.mockRepository = MockAppDataRepository()
        self.viewModel = MovieListViewModel(repository: self.mockRepository)
    }
    
    override func tearDown() {
        self.mockRepository = nil
        self.viewModel = nil
        super.tearDown()
    }
    
    func testFetchData_Success() async {
        await self.viewModel.fetchData()
        
        XCTAssertFalse(self.viewModel.isLoading)
        XCTAssertNil(self.viewModel.errorMessage)
        XCTAssertEqual(self.viewModel.movies.count, 2)
        XCTAssertEqual(self.viewModel.movies.first?.name, "The Fellowship of the Ring")
    }
    func testFetchData_Failure() async {
        self.mockRepository.shouldThrowError = true
        
        await self.viewModel.fetchData()
        
        XCTAssertFalse(self.viewModel.isLoading)
        XCTAssertNotNil(self.viewModel.errorMessage)
        XCTAssertEqual(self.viewModel.errorMessage, "Something went wrong. Please try again later.")
        XCTAssertTrue(self.viewModel.movies.isEmpty)
    }
    
    func testToggleFavorite() {
        
        let movie = Movie(id: "1", name: "The Fellowship of the Ring", runtimeInMinutes: 200, budgetInMillions: 300, boxOfficeRevenueInMillions: 300, academyAwardNominations: 25, academyAwardWins: 10, rottenTomatoesScore: 23)
        
        XCTAssertFalse(self.viewModel.isFavorite(movie))
        
        self.viewModel.toggleFavorite(movie)
        XCTAssertTrue(self.viewModel.isFavorite(movie))
        
        self.viewModel.toggleFavorite(movie)
        XCTAssertFalse(self.viewModel.isFavorite(movie))
    }
}
