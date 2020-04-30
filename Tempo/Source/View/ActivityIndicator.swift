//
//  Spinner.swift
//  Tempo
//
//  Created by Scott Takahashi on 16/05/20.
//  Copyright © 2020 hashiCode. All rights reserved.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        view.startAnimating()
        return view
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
//        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
