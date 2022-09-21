//
//  HomeView.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import SwiftUI
import FirebaseAuth

struct HomeScreenView: View {
    
    @EnvironmentObject private var authVM: AuthViewModel
    @StateObject private var homeVM = HomeViewModel()
    @State var currentStateType: StateType = StateType.featured
    @State var queryData: QueryData = QueryData()
    @State var searchTerm: String = ""
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HomeHeader(
                    searchTerm: $searchTerm,
                    stateType: $currentStateType,
                    queryData: $queryData
                )
                
                ScrollView {
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        Task {
                            await homeVM.refreshRecipes(currentQueryData: queryData)
                        }
                    }
                    
                    if currentStateType == .featured {
                        Text("Please search recipes")
                            .font(.system(.title, design: .rounded))
                    }
                    
                    if currentStateType == .search {
                        if homeVM.fetchingError {
                            ErrorCard {
                                Task {
                                    await homeVM.refreshRecipes(currentQueryData: queryData)
                                }
                            }
                        } else if !homeVM.recipesDidLoad(state: .search) {
                            VStack {
                                LoadingIndicator(text: "Getting recipes...", size: 2)
                            }
                            .frame(width: K.SCREEN_WIDTH, height: K.SCREEN_HEIGHT / 2)
                        } else if homeVM.fetchedRecipes.count == 0 {
                            NoRecipesFoundCard(searchTerm: searchTerm)
                        } else {
                            VStack {
                                ForEach(homeVM.fetchedRecipes) { recipe in
                                    VerticalMealCard(
                                        uri: recipe.recipe.uri,
                                        imageUrl: recipe.recipe.image,
                                        label: recipe.recipe.label,
                                        nutrients: recipe.recipe.totalNutrients,
                                        userID: authVM.session?.uid ?? ""
                                    )
                                    .environmentObject(authVM)
                                }
                            }
                        }
                    }
                    
                }
                .coordinateSpace(name: "pullToRefresh")
            }
        }
        .navigationTitle("Home")
        .navigationBarHidden(true)
        .onChange(of: searchTerm) { _ in
            Task {
                await homeVM.populateByQuery(query: searchTerm)
            }
        }
    }

}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(AuthViewModel())
    }
}
