//
//  RecipeDetailsVM.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 21.09.2022.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    
    @Published var recipeData: Result?
    @Published var recipeLoaded: Bool = false
    @Published var fetchingError: Bool = false
    
    func populateRecipeData(recipeID: String) async {
        
        DispatchQueue.main.async {
            self.recipeLoaded = false
            self.fetchingError = false
        }
        
        do {
            let recipeResponse = try await RecipeService().get(url: Constant.URLs.recipeById(recipeID)) { data in
                return try? JSONDecoder().decode(Result.self, from: data)
            }
            
            DispatchQueue.main.async {
                self.recipeData = recipeResponse
                self.recipeLoaded = true
            }
        } catch {
            DispatchQueue.main.async {
                self.fetchingError = true
            }
            print(error)
        }
    }
}
