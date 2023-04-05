//
//  WeatherHomeView.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import SwiftUI
import Lottie

struct WeatherHomeView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var currentCity = ""
    @State private var isNightView: Bool = true
    @State private var isCelsius: Bool = true
    @State private var isRaining = false
    
    @ObservedObject var viewModel: WeatherHomeViewModel
    
    init() {
        let weatherHomeModel = WeatherHomeModel()
        self.viewModel = WeatherHomeViewModel(model: weatherHomeModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if isNightView {
                    LinearGradient(gradient: Gradient(colors: [Color(red: 41/255, green: 56/255, blue: 73/255),
                                                               Color(red: 96/255, green: 117/255, blue: 146/255),
                                                               Color(red: 145/255, green: 170/255, blue: 194/255)]),
                                   startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                } else {
                    LinearGradient(gradient: Gradient(colors: [Color(.systemBlue),
                                                               Color(.systemTeal)]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                }
                GeometryReader { geo in
                    LottieView(lottieFile: isRaining ? .rainy : .clearSky, loopMode: .loop)
                        .frame(width: geo.size.width, height: 300).id(isRaining)
                }
                VStack(alignment: .center, spacing: 10) {
                    HStack {
                        Text("Today")
                            .font(.custom("Helvetica Neue", size: 32))
                            .fontWeight(.bold)
                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                        Spacer()
                        Button(action: {
                            withAnimation {
                                self.isSearching = true
                            }
                        }) {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.system(size: 34))
                        }.padding(.trailing, 5)
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                                .font(.title)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10).overlay(
                        Group {
                            if isSearching {
                                SearchBar(isSearching: $isSearching,
                                          searchText: $searchText).transition(.move(edge: .top))
                            }
                        }
                    )
                    Spacer()
                    VStack(alignment: .center, spacing: 10) {
                        if let weatherIcon = viewModel.weatherIcon {
                            Image(uiImage: weatherIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                        } else {
                            Image(systemName: "sun.max.fill")
                                .font(.system(size: 120))
                        }
                        Text("\(viewModel.convertTemperature(to: isCelsius ? "c":"f"))")
                            .font(.system(size: 60))
                            .fontWeight(.bold).onTapGesture {
                                withAnimation(.linear) {
                                    self.isCelsius.toggle()
                                }
                            }
                        Text("\(viewModel.weatherData?.weather?.first?.description ?? "--")")
                            .font(.title3)
                            .fontWeight(.medium)
                        Text($currentCity.wrappedValue)
                            .onReceive(viewModel.$currentCity) { newCity in
                                self.currentCity = newCity
                            }
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .padding(.top, 10)
                    Spacer()
                    HStack {
                        WeatherItemView(image: "wind", value: "\(viewModel.weatherData?.wind?.speed ?? 0) mph")
                        Spacer()
                        WeatherItemView(image: "drop.fill", value: "\(viewModel.weatherData?.main?.humidity ?? 0)%")
                        Spacer()
                        WeatherItemView(image: "umbrella.fill", value: viewModel.isRaining() ? "Rraining" : "No rain")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                }.foregroundColor(.white).onChange(of: isSearching) { isSearching in
                    if !isSearching && !self.$searchText.wrappedValue.isEmpty {
                        Task.detached {
                            await viewModel.fetchWeatherData(for: self.$searchText.wrappedValue)
                        }
                    }
                }.onChange(of: viewModel.weatherData) { newData in
                    isRaining = viewModel.isRaining()
                }.onChange(of: viewModel.isNight) { isNight in
                    self.isNightView = isNight
                }
            }
            
        }
    }
}
