//
//  SettingsView.swift
//  Basic Weather App
//
//  Created by Ayan Chakraborty on 05/04/23.
//

import SwiftUI
import UIKit

struct SettingsView: View {
    var body: some View {
            List {
                Section(header: Text("Support")) {
                    NavigationLink(destination: ContactUsView()) {
                        Label("Contact Us", systemImage: "envelope.circle")
                    }
                }
                Section(header: Text("About")) {
                    NavigationLink(destination: AboutUsView()) {
                        Label("About Us", systemImage: "info.circle")
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Settings"))
    }
}
