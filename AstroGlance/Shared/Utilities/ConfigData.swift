//
//  ConfigData.swift
//  AstroGlance
//
//  Created by Umesh Basnet on 2025-06-09.
//

import Foundation

class ConfigData {
    
    public static let shared = ConfigData()
    
    private init(){}
    
    func getApiKey() -> String? {
        return Bundle.main
            .object(forInfoDictionaryKey: "API_KEY") as? String
        
    }
    
}

