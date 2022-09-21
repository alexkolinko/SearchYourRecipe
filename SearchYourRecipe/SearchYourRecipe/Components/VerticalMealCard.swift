//
//  VerticalMealCard.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import SwiftUI

struct VerticalMealCard: View {
    
    let uri: String
    let imageUrl: String
    let label: String
    let nutrients: TotalNutrients
    let userID: String
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationLink {
            // Extract recipe ID from URI
            let recipeID = String(self.uri.suffix(32))
            RecipeDetailsView(recipeID: recipeID, userID: userID)
                .environmentObject(authVM)
                .toolbar(.hidden)
        } label: {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.5))
                    
                    Text(label)
                        .foregroundColor(Color.black)
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding(.vertical)
                }
                .padding([.leading, .trailing], 15)
                
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.gray.opacity(0.2))
                        LoadingIndicator()
                    }
                }
                .frame(height: 200)
                .cornerRadius(15)
                .shadow(radius: 5, x: 0, y: 5)
                .padding([.leading, .trailing], 15)
                
                NutrientStickers(nutrients: [
                    Nutrient(color: "sticker", label: "KCal", quantity: String(Int(nutrients.kcals.quantity)), units: "kcal"),
                    Nutrient(color: "sticker", label: "Protein", quantity: String(Int(nutrients.protein.quantity)), units: "g"),
                    Nutrient(color: "sticker", label: "Carbs", quantity: String(Int(nutrients.carbs.quantity)), units: "g"),
                    Nutrient(color: "sticker", label: "Sugars", quantity: String(Int(nutrients.sugars.quantity)), units: "g"),
                    Nutrient(color: "sticker", label: "Sat. Fat", quantity: String(Int(nutrients.satFat.quantity)), units: "g"),
                    Nutrient(color: "sticker", label: "Fiber", quantity: String(Int(nutrients.fiber.quantity)), units: "g")
                ])
            }
            .padding(.bottom, 40)
        }
    }
}
