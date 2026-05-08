//
//  UIKitInSwiftUIView.swift
//  WeatherApp
//
//  Created by Abhishek Khedekar on 27/04/26.
//

import SwiftUI

struct LoadingView: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    var loading: Bool

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView()
        return indicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        loading ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct UIKitInSwiftUIView: View {
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            LoadingView(loading: isLoading)
            Button("Toggle") {
                isLoading.toggle()
            }
        }
    }
}

struct UIKitInSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        UIKitInSwiftUIView()
    }
}
