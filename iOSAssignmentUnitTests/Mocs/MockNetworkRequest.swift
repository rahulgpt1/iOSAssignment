//
//  MockNetworkRequest.swift
//  iOSAssignmentUnitTests
//
//  Created by Rahul Gupta on 25/09/25.
//

import XCTest
@testable import iOSAssignment

final class MockNetworkRequest: NetworkRequestProtocol {
    var calledEndpoint: APIEndpoint?
    var shouldThrow = false
    var mockResponse: Any?

    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        self.calledEndpoint = endpoint

        if shouldThrow {
            throw URLError(.badServerResponse)
        }

        guard let result = mockResponse as? T else {
            throw URLError(.cannotParseResponse)
        }

        return result
    }
}
