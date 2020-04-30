//
//  SectionText.swift
//  Tempo
//
//  Created by Scott Takahashi on 16/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import SwiftUI

struct SectionText: View {
    
    private let textKey: LocalizedStringKey
    
    init(_ textKey: LocalizedStringKey){
        self.textKey = textKey
    }
    
    var body: some View {
        Text(textKey)
            .font(.title)
            .bold()
    }
}

struct SectionText_Previews: PreviewProvider {
    static var previews: some View {
        SectionText(LocalizedStringKey("Section"))
    }
}
