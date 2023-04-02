/*+===================================================================
File: SettingsView.swift

Summary: Central page to hold all settings options, such as sign out of user account

===================================================================+*/

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    
    @State var isOn = false;
    @State var isLoggedIn: Bool = false
    
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
                    
                    VStack {
                        VStack {
                            NavigationLink(destination:
                                LoginView(isLoggedIn: $isLoggedIn)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarTitle("")
                                .accessibilityLabel("signOutButton"))
                            {
                                VStack {
                                    Text("Sign Out")
                                        .font(.custom("Helvetica Neue", size: 22))
                                        .foregroundColor(.white)
                                        .frame(width: 350, alignment: .topLeading)

                                    Text("example@domain.com")
                                        .font(.custom("Helvetica Neue", size: 18))
                                        .accentColor(.gray)
                                        .frame(width: 350, alignment: .bottomLeading)
                                }
                            }
                        }
                        .padding(.vertical, 10)
                        
                        HStack {
                            VStack {
                                Text("Multiple Antenna Scan")
                                    .font(.custom("Helvetica Neue", size: 22))
                                    .foregroundColor(.white)
                                    .frame(width: 270, alignment: .topLeading)
                                
                                Text("Use all available attenas to scan at different heights")
                                    .font(.custom("Helvetica Neue", size: 18))
                                    .foregroundColor(.gray)
                                    .frame(width: 270, alignment: .topLeading)
                            }
                            Toggle("", isOn: $isOn)
                                .frame(width: 70)
                                .accessibilityLabel("settingsToggle")
                        }
                    }
                    .frame(width: 395, height: 600, alignment: .top)
                
                    Divider()
                        .overlay(.white)
                        .frame(width: 500, height: 650, alignment: .bottom)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .edgesIgnoringSafeArea(.all)

        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .previewInterfaceOrientation(.portrait)
    }
}
