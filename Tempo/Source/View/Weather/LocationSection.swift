//
//  LocationHeader.swift
//  Tempo
//
//  Created by Scott Takahashi on 10/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import SwiftUI

struct LocationSection: View {
    
    private let cityName: String
    
    init(_ cityName: String){
        self.cityName = cityName
    }
    
    var body: some View {
        VStack{
            HStack {
                Text(cityName)
                    .font(.largeTitle).bold()
                Image(systemName: "location.fill")
            }
        }
    }
}

struct LocationSection_Previews: PreviewProvider {
    static var previews: some View {
        LocationSection("São Paulo")
    }
}
