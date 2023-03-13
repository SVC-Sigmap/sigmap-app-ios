//
//  NavBar.swift
//  sigmap-ios
//
//  Created by Jack Puschnigg on 2023-03-02.
//

import SwiftUI

struct NavBar: View {
    @State private var selection = 1
    var body: some View {
        TabView(selection: $selection) {
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                        .imageScale(.large)
                    Text("Settings")
                }
            .tag(0)
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                        .resizable()
                        .font(.system(size: 46))
                    Text("Home")
                }
            .tag(1)
            
            LibraryView()
                .tabItem {
                    Image(systemName: "map.fill")
                        .imageScale(.large)
                    Text("Library")
                }
            .tag(2)
        }
        .accentColor(.white)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
