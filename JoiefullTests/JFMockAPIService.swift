//
//  JFMockAPIService.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 31/10/2024.
//

import XCTest
@testable import Joiefull



final class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        
        guard let data = mockData, let response = mockResponse else {
            throw URLError(.unknown)
        }
        return (data, response)
//        return (mockData ?? Data(), mockResponse ?? URLResponse())
    }
}

final class MockJFAPIService: JFAPIService {
    private var mockData: Data?
    private var mockResponse: URLResponse?
    private var mockError: Error?
    
    init(mockData: Data? = nil, mockResponse: URLResponse? = nil, mockError: Error? = nil) {
        self.mockData = mockData
        self.mockResponse = mockResponse
        self.mockError = mockError
        let mockSession = MockURLSession()
        mockSession.mockData = mockData
        mockSession.mockResponse = mockResponse
        mockSession.mockError = mockError
        super.init(session: mockSession)
    }
    
    override func createClothesRequest() -> URLRequest {
        return URLRequest(url: URL(string: "https://example.com")!)
    }
}
