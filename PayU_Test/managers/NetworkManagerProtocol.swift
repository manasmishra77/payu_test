//
//  NetworkManagerProtocol.swift
//  PayU_Test
//
//  Created by Manas1 Mishra on 19/12/20.
//

import Foundation


protocol NetworkManagerProtocol {
    func doNetworkCallForMovieList(searchKey: String, pageNo: Int, totalPage: Int, completion: @escaping NetworkManager.Completion) 
}
