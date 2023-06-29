//
//  CityCellView.swift
//  weather
//
//  Created by Joshua Ho on 6/25/23.
//

import SwiftUI

struct CityCellView: View {
    let cityWeather: WeatherData
    let viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(cityWeather.name)
                        .font(.title)
                        .minimumScaleFactor(0.5)
                    Text("\(cityWeather.formatTime())")
                }
                Spacer()
                Text("\(Int(cityWeather.mainData.temp))°")
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.8)
            }
            .padding()
            Spacer()
            HStack {
                Text(cityWeather.weather[0].main)
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(cityWeather.weather[0].icon).png"))
                Spacer()
                Text("H:\(Int(cityWeather.mainData.maxTemp))° L:\(Int(cityWeather.mainData.minTemp))°")
                Spacer()
                Button(action: {
                    if let index = viewModel.weatherFavorites.firstIndex(of: cityWeather) {
                        viewModel.weatherFavorites.remove(at: index)
                    }
                    else {
                        viewModel.weatherFavorites.append(cityWeather)
                    }
                }, label: {
                    if viewModel.weatherFavorites.contains(cityWeather) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(.white)
                    }
                })
            }
            .padding()
            .background(Color("avocado"))
            .foregroundColor(.white)
        }
        .frame(maxHeight: 200)
        .background(Color("isabelline"))
        .foregroundColor(.black)
        .cornerRadius(30)
    }
}

//struct CityCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CityCellView()
//    }
//}
