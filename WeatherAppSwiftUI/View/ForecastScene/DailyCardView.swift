//
//  DailyCardView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import SwiftUI

struct DailyCardView: View {

    var dayOfWeek: String
    var iconName: String
    var temperatureHigh: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(LinearGradient(gradient: Gradient(
                                        colors: [Color.white.opacity(0.3), Color.white.opacity(0.3)]),
                                                   startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack(alignment: .center) {
                Text(dayOfWeek.uppercased())
                    .font(.system(size: 24))
                    .fontWeight(.heavy)
                    .foregroundColor(ColorConstants.waLabelColor)
                Image(systemName: iconName)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                Text("\(temperatureHigh)")
                    .font(.system(size: 32))
                    .fontWeight(.heavy)
                    .foregroundColor(ColorConstants.waLabelColor)
            }
        }
        .frame(width: 120, height: 160)
        .cornerRadius(10)
    }
}
