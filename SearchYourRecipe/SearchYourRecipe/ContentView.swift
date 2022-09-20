//
//  ContentView.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    func getUser() {
        authVM.listen()
    }
    
    var body: some View {
        Group {
            if authVM.session != nil {
                HomeScreenView()
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}

