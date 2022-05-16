//
//  LoadingView.swift
//  WeatherAppSwiftUI
//
//  Created by Burak Tunc on 16.05.22.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isLoading:Bool
    var body: some View {
        if isLoading {
            ZStack{
                RoundedRectangle(cornerRadius: 15).fill(ColorConstants.backgroundColorSunnySecond.opacity(0.1))
                ProgressView {
                    Text("Loading...")
                        .font(.title2)
                }
            }.frame(width: 120, height: 120, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 25).stroke(ColorConstants.backgroundColorSunnySecond,lineWidth: 2))
        }
    }
}
