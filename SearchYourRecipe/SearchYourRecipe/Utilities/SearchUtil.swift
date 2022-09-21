//
//  SearchUtil.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import Foundation

class SearchUtil {
    
    func formatSearchTerm(searchTerm: String) -> String {
        
        let stringArray = searchTerm.components(separatedBy: " ")
        
        guard stringArray.count > 1 else { return searchTerm }
        
        let formattedSearchTerm = stringArray.joined(separator: "%20")
        
        return formattedSearchTerm
    }
}
