//
//  TodayCardView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import SwiftUI

struct TodayCardView: View {

    var cityArea: String
    var todayWeatherAnimation: String
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
            Text(currentTemperature)
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(ColorConstants.waLabelColor)
            WeatherAnimationView(fileName: todayWeatherAnimation, loopMode: .loop)
                .frame(width: 200, height: 200)
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
