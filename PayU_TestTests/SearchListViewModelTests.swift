//
//  SearchListViewModelTests.swift
//  PayU_TestTests
//
//  Created by Manas1 Mishra on 19/12/20.
//

import XCTest
@testable import PayU_Test

class SearchListViewModelTests: XCTestCase {
    
    var networkManager: MockNetworkManager!
    var viewModel: MovieListVCViewModel!
    var err: AppError?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkManager = MockNetworkManager()
        viewModel = MovieListVCViewModel(networkManager: networkManager, delegate: self)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testContentWithPage1Success() {
        // set up
        self.err = nil
        let searchKey = "abc"
        let exp = expectation(description: "Expect")
        networkManager.datamodelPath = .movielistpage1
        
        
        //execute
        self.viewModel.fetchMovie(searchKey: searchKey)
        
        
        XCTAssert(self.viewModel.currentSearchKey == searchKey, "Current search key not set")
        XCTAssert(self.viewModel.currentPageNo == 1, "Current page num not set")
        XCTAssert(self.viewModel.recommendations.contains(searchKey), "Recommendations should contain searchkey")


        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // assert
            XCTAssert(self.viewModel.totalPages == 2, "total pages not set")
            XCTAssert(self.err == nil, "error should be nil")
            XCTAssert(self.viewModel.isInApiCall == false, "Wrong apicall variable set")
            XCTAssert(self.viewModel.movieResponse != nil, "movieResponse should not be nil")

            exp.fulfill()
        }
        waitForExpectations(timeout: 40, handler: nil)
    }
    
    func testContentWithPage2Success() {
        // set up
        self.err = nil
        let searchKey = "abc"
        let exp = expectation(description: "Expect")
        networkManager.datamodelPath = .movielistpage1
        self.viewModel.fetchMovie(searchKey: searchKey)
        networkManager.datamodelPath = .movielistpage2
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // execute
            self.viewModel.fetchMovie(searchKey: searchKey)
            
            
            XCTAssert(self.viewModel.currentSearchKey == searchKey, "Current search key not set")
            XCTAssert(self.viewModel.currentPageNo == 1, "Current page num not set")
            XCTAssert(self.viewModel.recommendations.count == 1, "Recommendations contain more searchkey")


            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                // assert
                XCTAssert(self.viewModel.totalPages == 2, "total pages not set")
                XCTAssert(self.err == nil, "error should be nil")
                XCTAssert(self.viewModel.isInApiCall == false, "Wrong apicall variable set")
                XCTAssert(self.viewModel.currentPageNo == 2, "Current page num not set")
                XCTAssert(self.viewModel.movieResponse?.results?.count == 2, "movieResponse should be appended")

                exp.fulfill()
            }

        }
        
        waitForExpectations(timeout: 40, handler: nil)
    }
    
    func testContentWithPage3Call() {
        // set up
        self.err = nil
        let searchKey = "abc"
        let exp = expectation(description: "Expect")
        networkManager.datamodelPath = .movielistpage1
        self.viewModel.fetchMovie(searchKey: searchKey)
        networkManager.datamodelPath = .movielistpage2
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // execute
            self.viewModel.fetchMovie(searchKey: searchKey)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // execute
                self.viewModel.fetchMovie(searchKey: searchKey)
                
                // assert
                XCTAssert(self.viewModel.totalPages == 2, "total pages not set")
                XCTAssert(self.err == nil, "error should be nil")
                XCTAssert(self.viewModel.isInApiCall == false, "Wrong apicall variable set")
                XCTAssert(self.viewModel.currentPageNo == 2, "Current page num not set")
                XCTAssert(self.viewModel.movieResponse?.results?.count == 2, "movieResponse should be appended")
                
                exp.fulfill()
                
            }
        }
        
        
        waitForExpectations(timeout: 40, handler: nil)
    }
    
    func testContentWithPage1NewContentSuccess() {
        // set up
        self.err = nil
        let searchKey = "abc"
        let exp = expectation(description: "Expect")
        networkManager.datamodelPath = .movielistpage1
        self.viewModel.fetchMovie(searchKey: searchKey)
        networkManager.datamodelPath = .movielistpage2
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.fetchMovie(searchKey: searchKey)
            
            self.networkManager.datamodelPath = .movielistNewContent
            let newSearchKey = "def"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                self.viewModel.fetchMovie(searchKey: newSearchKey)
                
                XCTAssert(self.viewModel.currentSearchKey == newSearchKey, "Current search key not set")
                XCTAssert(self.viewModel.currentPageNo == 1, "Current page num not set")
                XCTAssert(self.viewModel.recommendations.count == 2, "Recommendations contain more searchkey")
            


                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    // assert
                    XCTAssert(self.viewModel.totalPages == 5, "total pages not set")
                    XCTAssert(self.err == nil, "error should be nil")
                    XCTAssert(self.viewModel.isInApiCall == false, "Wrong apicall variable set")
                    XCTAssert(self.viewModel.currentPageNo == 1, "Current page num not set")
                    XCTAssert(self.viewModel.movieResponse?.results?.count == 1, "movieResponse should be appended")

                    exp.fulfill()
                }

            }
        }
        
        waitForExpectations(timeout: 40, handler: nil)
    }
    

}

extension SearchListViewModelTests: MovieListVCViewModelDelegate {
    func newMovieFetchingStarted() {
        
    }
    
    func movieDataFetched(with err: AppError?) {
        self.err = err
    }
    
    
}
