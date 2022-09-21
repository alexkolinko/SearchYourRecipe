//
//  HomeVM.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var fetchedRecipes: [Result] = []
    @Published var recipesLoaded: Bool = false
    @Published var fetchingError: Bool = false
    
    func populateByQuery(query: String) async {
        
        DispatchQueue.main.async {
            self.recipesLoaded = false
            self.fetchingError = false
        }
        
        do {
            let recipesResponse = try await RecipeService().get(url: K.URLs.recipesByName(query)) { data in
                return try? JSONDecoder().decode(Recipes.self, from: data)
            }
            
            DispatchQueue.main.async {
                self.fetchedRecipes = recipesResponse.hits
                self.recipesLoaded = true
            }
        } catch {
            DispatchQueue.main.async {
                self.fetchingError = true
            }
            print(error)
        }
    }
    
    func refreshRecipes(currentQueryData: QueryData) async {
        if let query = currentQueryData.query {
            await populateByQuery(query: query)
        }
    }
    
    // Conditional rendering
    func recipesDidLoad(state: StateType) -> Bool {
        return recipesLoaded
    }
}



