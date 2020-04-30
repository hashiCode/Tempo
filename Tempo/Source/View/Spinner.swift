//
//  Spinner.swift
//  Tempo
//
//  Created by Scott Takahashi on 16/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import SwiftUI

struct Spinner: View {
    var body: some View {
        VStack {
            Text(LocalizedStringKey(Constants.view.kSpinnerLoading))
            ActivityIndicator(style: .large)
        }
        
        .padding()
        .background(Color.secondary.colorInvert())
        .cornerRadius(20)
    }
}

struct LoadingWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
