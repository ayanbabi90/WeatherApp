//
//  SearchBar.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var isSearching: Bool
    @Binding var searchText: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.linear(duration: 0.3)) {
                    isSearching = false
                }
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(isEditing ? .blue : .secondary)
            }
           
            TextField("Search for a city", text: $searchText, onEditingChanged: { editing in
                isEditing = editing
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .foregroundColor(.primary)
            Button(action: {
                withAnimation(.linear(duration: 0.3)) {
                    searchText = ""
                    isSearching = false
                }
            }) {
                Text("Cancel")
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
