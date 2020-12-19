//
//  AppManager.swift
//  SwiggyTest
//
//  Created by Manas1 Mishra on 28/10/20.
//

import UIKit

class AppManager: NSObject {
    static let shared = AppManager()
    var networkManager: NetworkManager {
        return NetworkManager.shared
    }
    
}

struct AppError: Error {
    var code: Int
    var msg: String
}


