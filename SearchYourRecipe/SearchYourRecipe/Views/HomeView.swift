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

    
    var body: some View {
        VStack {
            Text("Please search recipes")
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(AuthViewModel())
    }
}
