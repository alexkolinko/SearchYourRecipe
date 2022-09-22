//
//  NoRecipesFoundCard.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import SwiftUI

struct NoRecipesFoundCard: View {
    
    let searchTerm: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.white.opacity(0.7))
            .overlay {
                VStack {
                    VStack {
                        Text("No recipes found for search: \(searchTerm)")
                            .font(.system(.title2, design: .rounded))
                    }
                    .padding()
                }
            }
            .frame(width: 350, height: 150)
    }
}

struct NoRecipesFoundCard_Previews: PreviewProvider {
    static var previews: some View {
        NoRecipesFoundCard(searchTerm: "salad")
    }
}
