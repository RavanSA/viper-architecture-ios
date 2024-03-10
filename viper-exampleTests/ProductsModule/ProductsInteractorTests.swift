//
//  ProductsInteractorTests.swift
//  viper-exampleTests
//
//  Created by Revan SADIGLI on 10.03.2024.
//

import XCTest
@testable import viper_example

class ProductsInteractorTests: XCTestCase {
    
    var interactor: ProductsInteractor!
    var mockPresenter: MockProductsPresenter!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockProductsPresenter()
        mockNetworkManager = MockNetworkManager()
        interactor = ProductsInteractor(networkManager: mockNetworkManager)
        interactor.presenter = mockPresenter
    }
    
    override func tearDown() {
        mockPresenter = nil
        mockNetworkManager = nil
        interactor = nil
        super.tearDown()
    }
    
    func testDidFetchProducts_Success() {
        interactor.didFetchProducts(request: ProductsDTORequest())
        
        XCTAssertTrue(mockPresenter.onFetchProductsSucces(response: mockResponse))
    }
    
    func testDidFetchProducts_Failure() {
        let errorMessage = "Error message"
        mockNetworkManager.mockError = NSError(domain: "TestDomain", code: 404, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        
        interactor.didFetchProducts(request: ProductsDTORequest())
        
        XCTAssertTrue(mockPresenter.onFetchProductsFailed())
    }
    
}
