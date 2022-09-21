//
//  ErrorCard.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import SwiftUI

struct ErrorCard: View {
    
    var onTryAgain: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.white.opacity(0.7))
            .overlay {
                VStack {
                    VStack {
                        Text("Something went wrong")
                            .font(.system(.title2, design: .rounded))
                        Text("Please try again)")
                            .font(.system(.title3, design: .rounded))
                            .padding(.top, 5)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        onTryAgain()
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Try again")
                        }
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundColor(Color.black)
                    }
                    .buttonStyle(.bordered)
                    .padding()
                }
            }
            .frame(width: 350, height: 200)
    }
}
