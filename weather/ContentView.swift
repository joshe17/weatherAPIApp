//
//  ContentView.swift
//  weather
//
//  Created by Joshua Ho on 6/25/23.
//

import SwiftUI

struct ContentView: View {
    @State var searchText = ""
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                searchField
                ScrollView {
                    VStack {
                        Text("Current City Weather")
                            .font(.title3)
                            .padding(.top)
                        if let w = viewModel.weatherData {
                            CityCellView(cityWeather: w, viewModel: viewModel)
                                .padding()
                        }
                    }
                    VStack {
                        Text("Favorites")
                            .font(.title3)
                            .padding(.top)
                        ForEach(viewModel.weatherFavorites) { city in
                            CityCellView(cityWeather: city, viewModel: viewModel)
                                .padding(.horizontal)
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Weather")
            .background(Color("silver"))
        }
        .onAppear {
            viewModel.locationManager.viewDidLoad()
            if let lat = viewModel.locationManager.lat {
                if let lon = viewModel.locationManager.lon {
                    viewModel.getWeatherByCoords(lat: lat, lon: lon)
                }
            }
        }
    }
    
    
    private var searchField: some View {
        TextField("Search for city", text: $searchText)
            .padding()
            .background(Color("silverLight")) //Color.systemGray6
            .cornerRadius(15)
            .padding(.horizontal, 16)
            .onSubmit {
                if searchText == "" {
                    if let lat = viewModel.locationManager.lat {
                        if let lon = viewModel.locationManager.lon {
                            viewModel.getWeatherByCoords(lat: lat, lon: lon)
                        }
                    }
                } else  {
                    viewModel.getWeather(cityName: searchText)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
