//
//  LoadingIndicator.swift
//  SearchYourRecipe
//
//  Created by kolinko oleksandr on 20.09.2022.
//

import SwiftUI

struct LoadingIndicator: View {
    
    var text: String?
    var size: Double?
    
    var body: some View {
        ProgressView(text ?? "Loading...")
            .scaleEffect(size ?? 1)
            .font(.system(.body, design: .rounded))
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator(text: "Spinner", size: 2)
    }
}
