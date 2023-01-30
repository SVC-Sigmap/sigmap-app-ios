/*+===================================================================
File: SettingsView.swift

Summary: Central page to hold all settings options, such as sign out of user account

===================================================================+*/

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // background color
                Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                    .ignoresSafeArea()
            
                // placeholder text
                Text("Settings")
                    .foregroundColor(Color.white)
                
                Divider()
                    .overlay(.white)
                    .frame(width: 500, height: 630, alignment: .bottom)

                // navbar
                HStack(spacing: 60) {
                    NavigationLink(destination: SettingsView())
                    {
                        Image("SettingsButtonActive")
                    }
                    NavigationLink(destination: HomeView())
                    {
                        Image("ScanButton")
                    }
                    NavigationLink(destination: LibraryView())
                    {
                        Image("MapLibraryButton")
                    }
                }
                .frame(width: 500, height: 790, alignment: .bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
