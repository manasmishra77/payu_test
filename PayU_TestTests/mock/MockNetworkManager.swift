//
//  MockNetworkManager.swift
//  PayU_TestTests
//
//  Created by Manas1 Mishra on 19/12/20.
//

import Foundation
@testable import PayU_Test

class MockNetworkManager: NetworkManagerProtocol {
    var datamodelPath: ModelJSONPath = .movielistpage1
    func doNetworkCallForMovieList(searchKey: String, pageNo: Int, totalPage: Int, completion: @escaping NetworkManager.Completion) {
        let bundle = Bundle(for: type(of: self))
        let model = loadModel(datamodelPath.rawValue, as: MovieListResponse.self, bundle: bundle)
        completion(200, model, nil)
    }
    
    
}
