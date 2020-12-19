//
//  MockDataGet.swift
//  PayU_TestTests
//
//  Created by Manas1 Mishra on 19/12/20.
//

import Foundation

enum ModelJSONPath: String {
    case movielistpage1 = "MovieListResult_Page1"
    case movielistpage2 = "MovieResultPage_2"
    case movielistBlankContent = "MovieResultBlankContent"
    case movielistNewContent = "MovieResultNewContent"
}

func loadModel<T: Decodable>(_ fileName: String, as type: T.Type = T.self, bundle: Bundle) -> T {
    let data: Data
    
    //let url = bundle.url(forResource: fileName, withExtension: "json")
    
    
    guard let file = bundle.url(forResource: fileName, withExtension: "json") else {
        fatalError("Couldn't find \(fileName) in bundle")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch  {
        fatalError("Couldn't find \(fileName) in bundle with error: \(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch  {
        print(error)
        fatalError("Couldn't find \(fileName) in bundle as \(T.self) with error: \(error)")
    }
}
