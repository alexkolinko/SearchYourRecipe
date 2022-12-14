//
//  AuthView.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject private var authVM: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text("Search Your Recipe")
                    .font(.system(.title, design: .rounded))
                
                Text("— Сontinue with —").font(.system(.body, design: .rounded))
                    .padding(.vertical, 35)
                
                Button(action: {
                    authVM.signInWithGoogle()
                }) {
                    HStack {
                        Image("GoogleLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                    }
                }
                .frame(height: 50)
                .padding()
                .buttonStyle(.bordered)
                
            }
            .padding()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
