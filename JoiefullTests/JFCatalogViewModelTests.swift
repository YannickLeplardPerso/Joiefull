//
//  JFCatalogViewModelTests.swift
//  Joiefull
//
//  Created by Yannick LEPLARD on 31/10/2024.
//

import XCTest
@testable import Joiefull



final class JFCatalogViewModelTests: XCTestCase {
    var viewModel: JFCatalogViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = JFCatalogViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(viewModel.clothes.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.error, .no)
        XCTAssertTrue(viewModel.categories.isEmpty)
    }
    
    func testFetchClothes_Success() async throws {
        // Given
        let jsonString = """
        [
            {
                "id": 1,
                "picture": {
                    "url": "https://example.com/image.jpg",
                    "description": "Test Image"
                },
                "name": "Test Item",
                "category": "ACCESSORIES",
                "likes": 10,
                "price": 29.99,
                "original_price": 39.99
            }
        ]
        """
        
        let mockService = MockJFAPIService(
            mockData: jsonString.data(using: .utf8)!,
            mockResponse: HTTPURLResponse(
                url: URL(string: "https://example.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
        )
        
        viewModel = JFCatalogViewModel(apiService: mockService)
        
        // When
        await viewModel.fetchClothes()
        
        // Then
        XCTAssertEqual(viewModel.clothes.count, 1)
        XCTAssertEqual(viewModel.clothes.first?.name, "Test Item")
        XCTAssertEqual(viewModel.error, .no)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testFetchClothes_Error() async throws {
        // Given
        let mockService = MockJFAPIService(
            mockError: JFError.requestDefault
        )
        
        viewModel = JFCatalogViewModel(apiService: mockService)
        
        // When
        await viewModel.fetchClothes()
        
        // Then
        XCTAssertTrue(viewModel.clothes.isEmpty)
        XCTAssertEqual(viewModel.error, .fetchClothes)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testCategories() {
        // Given
        let items = [
            JFClothingItem(
                id: 1,
                picture: JFPicture(url: URL(string: "https://example.com/1.jpg")!,
                                 description: "Test 1"),
                name: "Item 1",
                category: .accessories,
                likes: 10,
                price: 29.99,
                original_price: 39.99
            ),
            JFClothingItem(
                id: 2,
                picture: JFPicture(url: URL(string: "https://example.com/2.jpg")!,
                                 description: "Test 2"),
                name: "Item 2",
                category: .tops,
                likes: 5,
                price: 19.99,
                original_price: 29.99
            )
        ]
        
        // When
        viewModel.clothes = items
        
        // Then
        XCTAssertEqual(viewModel.categories.count, 2)
        XCTAssertTrue(viewModel.categories.contains("Accessoires"))
        XCTAssertTrue(viewModel.categories.contains("Hauts"))
    }
    
    func testToggleLike() {
        // Given
        let item = JFClothingItem(
            id: 1,
            picture: JFPicture(url: URL(string: "https://example.com/1.jpg")!,
                             description: "Test 1"),
            name: "Item 1",
            category: .accessories,
            likes: 10,
            price: 29.99,
            original_price: 39.99
        )
        viewModel.clothes = [item]
        
        // When
        viewModel.toggleLike(for: item)
        
        // Then
        XCTAssertTrue(viewModel.clothes.first?.isLiked ?? false)
        
        // When toggle again
        viewModel.toggleLike(for: item)
        
        // Then
        XCTAssertFalse(viewModel.clothes.first?.isLiked ?? true)
    }
    
    func testToggleLike_NonExistentItem() {
        // Given
        let existingItem = JFClothingItem(
            id: 1,
            picture: JFPicture(url: URL(string: "https://example.com/1.jpg")!,
                             description: "Test 1"),
            name: "Item 1",
            category: .accessories,
            likes: 10,
            price: 29.99,
            original_price: 39.99
        )
        
        let nonExistingItem = JFClothingItem(
            id: 2,
            picture: JFPicture(url: URL(string: "https://example.com/2.jpg")!,
                             description: "Test 2"),
            name: "Item 2",
            category: .accessories,
            likes: 10,
            price: 29.99,
            original_price: 39.99
        )
        
        viewModel.clothes = [existingItem]
        
        // When
        viewModel.toggleLike(for: nonExistingItem)
        
        // Then
        XCTAssertFalse(viewModel.clothes.first?.isLiked ?? true)
    }
}
