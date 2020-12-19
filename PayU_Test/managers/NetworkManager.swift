//
//  NetworkManager.swift
//  SwiggyTest
//
//  Created by Manas1 Mishra on 28/10/20.
//

import UIKit

class NetworkManager: NSObject, NetworkManagerProtocol {
    static let shared = NetworkManager()
        
    var apiKey: String {
        return "c8fd43eb56e81c44f40e95ad7923f7e1"
    }
    
    typealias Completion = (_ code: Int, _ model: Any?, _ error: Error?) -> ()
    
    struct NetworkError: Error {
        var code: Int
        var msg: String
    }
    
    enum EndPoint: String {
         
        case getMovieList = "?api_key=c8fd43eb56e81c44f40e95ad7923f7e1&query="
        
        var baseDomain: String {
            return "https://api.themoviedb.org/3/search/movie"
        }
        
        func getMovieListFullPath(searchKey: String, pageNo: Int) -> URL? {
            return URL(string: (baseDomain + self.rawValue + searchKey + "&page=\(pageNo)"))
            
        }
        
        func getMovieDetailsFullPath(id: String) -> URL? {
            return URL(string: (baseDomain + self.rawValue + id))
        }
    }
        
    
    func doNetworkCallForMovieList(searchKey: String, pageNo: Int, totalPage: Int, completion: @escaping Completion) {
        // totalpage should be grater than pageno
        if totalPage < pageNo {
            completion(452, nil, NetworkError(code: 452, msg: "pageno is greater than total page") )
            return
        }
        
        // check url from string
        guard let url = EndPoint.getMovieList.getMovieListFullPath(searchKey: searchKey, pageNo: pageNo) else {
            completion(451, nil, NetworkError(code: 451, msg: "url making failed") )
            return
        }
        
        doNetworkCall(url: url) { (code, data, error) in
            if let error = error {
                // error from response
                completion(code, nil, NetworkError(code: code, msg: error.localizedDescription) )
                return
            }
            let resModel = self.parseData(data as? Data, modelType: MovieListResponse.self)
            if let error = resModel.e {
                // error in parsing
                completion(460, nil, NetworkError(code: code, msg: error.localizedDescription))
                return
            }
            if let model = resModel.m {
                // success
                completion(code, model, nil)
            } else {
                completion(code, nil, nil)
            }
        }
    }
    
    
    func doNetworkCall(url: URL, completion: @escaping Completion) {

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        session.configuration.timeoutIntervalForRequest = 10
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            if let res = response as? HTTPURLResponse {
                if let err = error {
                    completion(res.statusCode, nil, err)
                    return
                }
                completion(res.statusCode, data, nil)
            } else {
                completion(500, nil, NetworkError(code: 500, msg: "No response"))
            }
        })

        task.resume()
    }
    
    func parseData<T: Codable>(_ data: Data?, modelType: T.Type) -> (m: T?, e: Error?) {
        guard let data = data else {
            return (nil, NetworkError(code: 450, msg: "No data"))
        }
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return (model, nil)
        } catch {
            return (nil, error)
        }
    }
    
    
}


