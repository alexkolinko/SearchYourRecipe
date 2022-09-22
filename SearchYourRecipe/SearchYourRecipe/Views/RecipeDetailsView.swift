//
//  RecipeDetailsView.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 21.09.2022.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    let recipeID: String
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var recipeDetailsVM = RecipeDetailViewModel()
    @State private var showNutrientList: Bool = false
    @State private var showIngredientList: Bool = false
    @State private var showWebView: Bool = false
    
    var body: some View {
        
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                NavigationBar(
                    dismiss: dismiss,
                    pinButton: !recipeDetailsVM.fetchingError ? true : false,
                    recipeID: recipeID
                )
                
                if recipeDetailsVM.fetchingError {
                    ErrorCard {
                        Task {
                            await recipeDetailsVM.populateRecipeData(recipeID: recipeID)
                        }
                    }
                } else if !recipeDetailsVM.recipeLoaded {
                    VStack {
                        LoadingIndicator(text: "Geting recipe info...", size: 2)
                    }
                    .frame(width: Constant.SCREEN_WIDTH, height: Constant.SCREEN_HEIGHT / 2)
                } else if let recipeData = recipeDetailsVM.recipeData?.recipe {
                    AsyncImage(url: URL(string: recipeData.image)) { image in
                        ZStack {
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                        }
                    } placeholder: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.gray.opacity(0.2))
                            LoadingIndicator()
                        }
                        .scaledToFit()
                    }
                    .shadow(radius: 5, x: 0, y: 5)
                    .padding([.trailing, .leading, .bottom], 5)
                    
                    VStack {
                        HStack {
                            Text(recipeData.label)
                                .font(.system(size: 30, weight: .heavy, design: .rounded))
                            
                            Spacer()
                        }
                        .padding([.trailing, .leading, .bottom], 5)
                        
                        VStack {
                            HStack {
                                Text("Nutrition Values")
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.medium)
                            }
                            
                            VStack {
                                NutrientStickersRowLarge(nutrients: [
                                    Nutrient(
                                        color: "sticker",
                                        label: "KCal",
                                        quantity: String(Int(recipeData.totalNutrients.kcals.quantity)),
                                        units: "kcal"
                                    ),
                                    Nutrient(
                                        color: "sticker",
                                        label: "Protein",
                                        quantity: String(Int(recipeData.totalNutrients.protein.quantity)),
                                        units: "g"
                                    )
                                ])
                                NutrientStickersRowLarge(nutrients: [
                                    Nutrient(
                                        color: "sticker",
                                        label: "Carbs",
                                        quantity: String(Int(recipeData.totalNutrients.carbs.quantity)),
                                        units: "g"
                                    ),
                                    Nutrient(
                                        color: "sticker",
                                        label: "Sugars",
                                        quantity: String(Int(recipeData.totalNutrients.sugars.quantity)),
                                        units: "g"
                                    )
                                ])
                                NutrientStickersRowLarge(nutrients: [
                                    Nutrient(
                                        color: "sticker",
                                        label: "Sat. Fat",
                                        quantity: String(Int(recipeData.totalNutrients.satFat.quantity)),
                                        units: "g"
                                    ),
                                    Nutrient(
                                        color: "sticker",
                                        label: "Fiber",
                                        quantity: String(Int(recipeData.totalNutrients.fiber.quantity)),
                                        units: "g"
                                    )
                                ])
                            }
                        }
                        .padding([.trailing, .leading, .bottom], 5)
                        
                        VStack {
                            HStack {
                                Text("Ingredients")
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.medium)
                                    .padding(.bottom, 5)
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        ForEach(recipeData.ingredientLines, id: \.self) { line in
                                            Text(line)
                                                .font(.system(.title3, design: .rounded))
                                                .padding(.bottom, 0.2)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                            }
                            
                            VStack {
                                HStack {
                                    Text("More info")
                                        .font(.system(.title, design: .rounded))
                                        .fontWeight(.medium)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 10)
                                
                                HStack {
                                    Button(action: {
                                        showWebView.toggle()
                                    }) {
                                        HStack {
                                            Image(systemName: "info.circle")
                                                .font(.system(.body, design: .rounded))
                                                .foregroundColor(Color.white)
                                            Text("Go to webpage")
                                                .font(.system(.title2, design: .rounded))
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .buttonStyle(.bordered)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .padding()
                        .sheet(isPresented: $showWebView) {
                            VStack {
                                VStack {
                                    Capsule()
                                        .foregroundColor(Color.gray)
                                        .frame(width: 100, height: 5)
                                        .padding(.top, 10)
                                    
                                    HStack {
                                        Button(action: {
                                            showWebView.toggle()
                                        }) {
                                            Image(systemName: "xmark.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(Color.black)
                                        }
                                        
                                        Spacer()
                                    }
                                    .frame(height: 25)
                                    .padding(.horizontal, 10)
                                }
                                WebView(url: URL(string: recipeData.url)!)
                            }
                        }
                    }
                }
            }
            .task {
                await recipeDetailsVM.populateRecipeData(recipeID: recipeID)
            }
        }
    }
    
    struct RecipeDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            RecipeDetailsView(recipeID: "d086f51bd7ca046eac74bda9198ece46")
                .environmentObject(AuthViewModel())
        }
    }
}
