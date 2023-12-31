//
//  M_M_AppTests.swift
//  M_M_AppTests
//
//  Created by Mariana Laic on 2023-10-14.
//

import XCTest
@testable import M_M_App

final class M_M_AppTests: XCTestCase {
    
    var sut: ApiCall!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ApiCall()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    /// Mark: OWN TESTING FUNCTION
     
    // testing throws, expect to go wrong because wrong endpoint
    func testFetchAdvice() async throws {
        
        do{
            let endpoint = "anotherTestOfHttpsAdress"
            try await sut.fetchAdvice(endpoint: endpoint)
            // Om inget fel kastas misslyckas testet
            XCTFail("Error did not throw it should have")
            
        }catch{
            
        }
    }
    
    
    // testing throws, expect to not go wrong , correct endpoint
    func apiTest() async throws {
       
        do {
            let endpoint = "https://api.adviceslip.com/advice"
            try await sut.fetchAdvice(endpoint: endpoint)
            
        }catch{
            // If it throws message Error
            XCTFail("Error did not throw when it should have")
        }
    }
    
    
    
    
    // testing Api if it is empty
    func apiEmtyTest() async throws {
        
        do{
            let endpoint = "https://api.adviceslip.com/advice"
            let advice = try await sut.fetchAdvice(endpoint: endpoint)
            // Advice should not be empty
            XCTAssertFalse(advice.isEmpty, "Advice should not be empty")
            
        }catch{
            // if it throws message Error
            XCTFail("An error occurred")
        }
    }
    
    
    
    
    
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
