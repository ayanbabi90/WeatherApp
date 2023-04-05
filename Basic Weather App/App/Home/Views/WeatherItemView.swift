//
//  WeatherItemView.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import SwiftUI

struct WeatherItemView: View {
    let image: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Image(systemName: image)
                .font(.system(size: 25))
            Text(value)
                .font(.caption)
        }
    }
}
