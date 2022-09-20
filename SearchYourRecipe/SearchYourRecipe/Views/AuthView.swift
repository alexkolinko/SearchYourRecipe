//
//  AuthView.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject private var authVM: AuthViewModel
    @State private var enteredEmail: String = ""
    @State private var enteredPassword: String = ""
    @State private var showError: Bool = false
    @State private var errorText: String = ""
    @State var showSignUpSheet: Bool = false
    
    var body: some View {
        VStack {
            
            Text("Eat Right")
                .font(.system(.title, design: .rounded))
                .foregroundColor(Color.gray)
            
            
            Text("—— Сontinue with ——").font(.system(.body, design: .rounded))
                .foregroundColor(Color.black).opacity(0.6)
                .padding(.vertical, 30)
            
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
