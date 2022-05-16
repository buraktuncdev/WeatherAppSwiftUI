//
//  ExtrasView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import SwiftUI

struct ExtrasView: View {

    var windSpeed: String
    var humidity: String
    var visibility: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(LinearGradient(gradient: Gradient(
                                        colors: [Color.white.opacity(0.3), Color.white.opacity(0.3)]),
                                                   startPoint: .topLeading, endPoint: .bottomTrailing))
            HStack(spacing: 48) {
                VStack(spacing: 8) {
                    Image(systemName: Constants.ExtrasView.windSpeedIcon)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text("\(windSpeed)\(Constants.ExtrasView.windSpeedType)")
                        .fontWeight(.bold)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text(Constants.ExtrasView.windSpeedTitle)
                        .fontWeight(.regular)
                        .foregroundColor(ColorConstants.waLabelColor)
                }

                VStack(spacing: 8) {
                    Image(systemName: Constants.ExtrasView.humidityIcon)
                        .resizable()
                        .frame(width: 26, height: 20)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text(humidity)
                        .fontWeight(.bold)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text(Constants.ExtrasView.humidityTitle)
                        .fontWeight(.regular)
                        .foregroundColor(ColorConstants.waLabelColor)
                }

                VStack(spacing: 8) {
                    Image(systemName: Constants.ExtrasView.visibilityIcon)
                        .resizable()
                        .frame(width: 26, height: 20)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text(visibility)
                        .fontWeight(.bold)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text(Constants.ExtrasView.visibilityTitle)
                        .fontWeight(.regular)
                        .foregroundColor(ColorConstants.waLabelColor)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.width / 4)
        .cornerRadius(10)
    }
}
