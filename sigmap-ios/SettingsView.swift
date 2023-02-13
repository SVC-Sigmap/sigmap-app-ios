/*+===================================================================
File: SettingsView.swift

Summary: Central page to hold all settings options, such as sign out of user account

===================================================================+*/

import SwiftUI

struct SettingsView: View {
    
    @State var isOn = false;
    
    var body: some View {
        HStack {
            NavigationView {
                ZStack {
                    // background color
                    Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                        .ignoresSafeArea()
                
                    // placeholder text
                    Text("Settings")
                        .font(.custom("Helvetica Neue", size: 26))
                        .foregroundColor(.white)
                        .frame(width:350, height: 725, alignment: .topLeading)
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.white)
                        .frame(width: 500, height: 630, alignment: .top)
                    
                    Text("Sign Out")
                        .font(.custom("Helvetica Neue", size: 22))
                        .foregroundColor(.white)
                        .frame(width: 350, height: 590, alignment: .topLeading)
                    
                    Text("example@domain.com")
                        .font(.custom("Helvetica Neue", size: 18))
                        .accentColor(.gray)
                        .frame(width: 350, height: 540, alignment: .topLeading)
                    
                    Text("Multiple Antenna Scan")
                        .font(.custom("Helvetica Neue", size: 22))
                        .foregroundColor(.white)
                        .frame(width: 350, height: 490, alignment: .topLeading)
                    
                    Text("Use all available attenas to scan at different heights")
                        .font(.custom("Helvetica Neue", size: 18))
                        .foregroundColor(.gray)
                        .frame(width: 350, height: 440, alignment: .topLeading)
                    
                    Toggle("", isOn: $isOn)
                        .frame(width:350, height: 490, alignment: .topTrailing)
                
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .previewInterfaceOrientation(.portrait)
    }
}
