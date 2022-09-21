//
//  HomeHeader.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import SwiftUI

struct HomeHeader: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var searchTerm: String
    @Binding var stateType: StateType
    @Binding var queryData: QueryData
    @State private var text: String = ""
    
    var body: some View {
        HStack {
            TextField("Search for a recipe", text: $text)
                .textFieldStyle(GradientTextFieldBackground())
                .onSubmit {
                    guard $text.wrappedValue.count > 0 else { return }
                    
                    searchTerm = SearchUtil().formatSearchTerm(searchTerm: $text.wrappedValue)
                    stateType = .search
                    queryData = QueryData(query: searchTerm)
                }
        }
        .frame(width: K.SCREEN_WIDTH - 30, height: 40)
        .padding(.vertical)
    }
}

struct GradientTextFieldBackground: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(height: 40)
            
            HStack {
                Image(systemName: "magnifyingglass")
                
                // Reference the TextField here
                configuration
            }
            .padding(.leading)
            .foregroundColor(.gray)
        }
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeader(
            searchTerm: .constant(""),
            stateType: .constant(.featured),
            queryData: .constant(QueryData())
        )
        .environmentObject(AuthViewModel())
    }
}
