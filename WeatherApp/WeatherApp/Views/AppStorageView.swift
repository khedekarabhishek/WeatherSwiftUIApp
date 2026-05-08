//
//  AppStorageView.swift
//  WeatherApp
//
//  Created by Abhishek Khedekar on 27/04/26.
//

import SwiftUI

struct AppStorageView: View {
    @AppStorage("FirstName") var firstName = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Details") {
                        TextField("Firt Name", text: $firstName)
                    }
                }
            }
            
        }
        .navigationTitle("AppStorage")
    }
}

struct AppStorageView_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageView()
    }
}
