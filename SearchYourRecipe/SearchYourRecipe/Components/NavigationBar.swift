//
//  NavigationBar.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 21.09.2022.
//

import SwiftUI

struct NavigationBar: View {
    
    var dismiss: DismissAction
    var title: String?
    var pinButton: Bool = false
    var recipeID: String?
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.white)
            }
            
            Spacer()
            
            if title != nil {
                Text(title!)
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(Color.white)
                    .frame(alignment: .center)
            }
            
            Spacer()
            
            Button(action: {
                authVM.signOut()
            }) {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.forward")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(Color.white)
                    Text("Sign out")
                        .font(.system(.title2, design: .rounded))
                        .foregroundColor(Color.white)
                }
            }
            .buttonStyle(.bordered)
        }
        .frame(height: 25)
        .padding()
    }
}
