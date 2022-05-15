//
//  ExtrasView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import SwiftUI

struct ExtrasView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(LinearGradient(gradient: Gradient(
                                        colors: [Color.white.opacity(0.3), Color.white.opacity(0.3)]),
                                                   startPoint: .topLeading, endPoint: .bottomTrailing))
            HStack(spacing: 48) {
                VStack(spacing: 8) {
                    Image(systemName: "wind")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text("8km/h")
                        .fontWeight(.bold)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text("Wind Speed")
                        .fontWeight(.regular)
                        .foregroundColor(ColorConstants.waLabelColor)
                }

                VStack(spacing: 8) {
                    Image(systemName: "humidity")
                        .resizable()
                        .frame(width: 26, height: 20)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text("47%")
                        .fontWeight(.bold)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text("Humidity")
                        .fontWeight(.regular)
                        .foregroundColor(ColorConstants.waLabelColor)
                }

                VStack(spacing: 8) {
                    Image(systemName: "eye")
                        .resizable()
                        .frame(width: 26, height: 20)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text("1.4km")
                        .fontWeight(.bold)
                        .foregroundColor(ColorConstants.waLabelColor)
                    Text("Visibility")
                        .fontWeight(.regular)
                        .foregroundColor(ColorConstants.waLabelColor)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.width / 4)
        .cornerRadius(10)

    }
}