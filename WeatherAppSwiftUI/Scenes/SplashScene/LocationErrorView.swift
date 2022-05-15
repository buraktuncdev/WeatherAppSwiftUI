//
//  ErrorView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 15.05.22.
//

import SwiftUI

struct LocationErrorView: View {

    @StateObject var forecastViewModel = ForecastViewModel()
    @StateObject var locationViewModel = LocationViewModel()

    @State var isActiveSecondView: Bool

    var errorMessage: String

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(
                    colors: [Color.yellow.opacity(0.6), Color.purple.opacity(0.4)]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 16) {
                    Image(systemName: "gear")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 80, height: 80, alignment: .center)

                    Text(errorMessage)

                    NavigationLink(destination: ForecastView(forecastViewModel: forecastViewModel).environmentObject(locationViewModel),
                                   isActive: $isActiveSecondView) { EmptyView() }

                    Button(action: {
                        self.isActiveSecondView = true
                    }, label: {
                        Label("Use Without Location", systemImage: "cloud.drizzle.fill")
                    })
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding()
                .foregroundColor(ColorConstants.waLabelColor)
                .background(ColorConstants.waLabelColor.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}
