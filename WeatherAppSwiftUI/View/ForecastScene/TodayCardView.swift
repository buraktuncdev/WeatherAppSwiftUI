//
//  TodayCardView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import SwiftUI

struct TodayCardView: View {

    var cityArea: String
    var todayWeatherIcon: String
    var currentTemperature: String
    var currentTime: String


    var body: some View {
        VStack {
            Text(cityArea.capitalized)
                .font(.system(size: 32))
                .fontWeight(.heavy)
                .foregroundColor(ColorConstants.waLabelColor)
                .lineLimit(2)
            Text(currentTime)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(ColorConstants.waLabelColor)
            Image(systemName: todayWeatherIcon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Text(currentTemperature)
                .font(.system(size: 54))
                .fontWeight(.bold)
                .foregroundColor(ColorConstants.waLabelColor)
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
