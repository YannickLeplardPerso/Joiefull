//
//  JFAPIServiceTests.swift
//  JFAPIServiceTests
//
//  Created by Yannick LEPLARD on 31/10/2024.
//

import XCTest
@testable import Joiefull



final class JFAPIServiceTests: XCTestCase {
    // Test de l'initialisation et de l'URL de base
    func testInit() {
        let service = JFAPIService()
        XCTAssertNotNil(service)
        XCTAssertNotNil(JFAPIService.BASE_URL)
    }
    
    // Test de createClothesRequest
    func testCreateClothesRequest() {
        let service = JFAPIService()
        let request = service.createClothesRequest()
        
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url, JFAPIService.BASE_URL)
    }

    // Test de succès existant
    func testAskForClothes_SuccessfulResponse() async throws {
        let jsonString = """
        [
            {
                "id": 1,
                "picture": {
                    "url": "https://example.com/image1.png",
                    "description": "Sample Image"
                },
                "name": "Test Item",
                "category": "ACCESSORIES",
                "likes": 12,
                "price": 29.99,
                "original_price": 39.99
            }
        ]
        """
        let mockData = jsonString.data(using: .utf8)!
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                         statusCode: 200,
                                         httpVersion: nil,
                                         headerFields: nil)
        
        let service = MockJFAPIService(mockData: mockData, mockResponse: mockResponse)
        
        let items = try await service.askForClothes()
        
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.name, "Test Item")
        XCTAssertEqual(items.first?.category, .accessories)
        XCTAssertEqual(items.first?.likes, 12)
    }
    
    // Test d'erreur réseau
    func testAskForClothes_NetworkError() async {
        let service = MockJFAPIService(mockError: URLError(.notConnectedToInternet))
        
        do {
            _ = try await service.askForClothes()
            XCTFail("Une erreur réseau était attendue")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .notConnectedToInternet)
        } catch {
            XCTFail("Erreur inattendue : \(error)")
        }
    }
    
    // Test de réponse invalide
    func testAskForClothes_InvalidResponse() async {
        let service = MockJFAPIService(mockData: Data(), mockResponse: URLResponse())
        
        do {
            _ = try await service.askForClothes()
            XCTFail("Une erreur de réponse était attendue")
        } catch let error as JFError {
            XCTAssertEqual(error, .requestResponse)
        } catch {
            XCTFail("Erreur inattendue : \(error)")
        }
    }
    
    // Test de status code invalide
    func testAskForClothes_InvalidStatusCode() async {
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                         statusCode: 404,
                                         httpVersion: nil,
                                         headerFields: nil)
        
        let service = MockJFAPIService(mockData: Data(), mockResponse: mockResponse)
        
        do {
            _ = try await service.askForClothes()
            XCTFail("Une erreur de status code était attendue")
        } catch let error as JFError {
            XCTAssertEqual(error, .requestDefault)
        } catch {
            XCTFail("Erreur inattendue : \(error)")
        }
    }
    
    // Test d'erreur de décodage
    func testAskForClothes_DecodingError() async {
        let invalidJSON = "invalid json".data(using: .utf8)!
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                         statusCode: 200,
                                         httpVersion: nil,
                                         headerFields: nil)
        
        let service = MockJFAPIService(mockData: invalidJSON, mockResponse: mockResponse)
        
        do {
            _ = try await service.askForClothes()
            XCTFail("Une erreur de décodage était attendue")
        } catch let error as JFError {
            XCTAssertEqual(error, .decodingJSON)
        } catch {
            XCTFail("Erreur inattendue : \(error)")
        }
    }
}
