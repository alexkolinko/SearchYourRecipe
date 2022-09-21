//
//  Constants.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import UIKit
import SwiftUI

struct K {
    static let BASE_URL = "https://api.edamam.com/api/recipes/v2"
    static let API_KEY = "5899a2ef01f21002e3741069d93c3207"
    static let APP_ID = "185c1951"
    
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    
    struct URLs {
        static func recipesByName(_ name: String) -> URL {
            return URL(string: "\(K.BASE_URL)?type=public&beta=false&q=\(name)&app_id=\(K.APP_ID)&app_key=\(K.API_KEY)")!
        }
        
        static func recipeById(_ id: String) -> URL {
            return URL(string: "\(K.BASE_URL)/\(id)?type=public&app_id=\(K.APP_ID)&app_key=\(K.API_KEY)")!
        }
        
    }
}

extension Color {
    static var background: Color {
        Color("background")
    }
}
