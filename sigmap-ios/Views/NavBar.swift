/*+===================================================================
File: NavBar.swift

Summary: Allows for the navigation between views

===================================================================+*/

import SwiftUI

struct NavBar: View {
    @State private var selection = 1
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                .tag(1)
                
                LibraryView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Library")
                    }
                .tag(2)
            }
            .accentColor(.white)
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
