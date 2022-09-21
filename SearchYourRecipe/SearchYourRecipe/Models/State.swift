//
//  State.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import Foundation

enum StateType {
    case featured
    case search
}

struct QueryData {
    var query: String?
}
