/*+===================================================================
File: ContentView.swift

Summary: Serves as the home page of the Sigmap mobile app. Scans are able to started / stopped from here, and users are able to check the status and battery of their robot.

===================================================================+*/


import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // background color
                Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                    .ignoresSafeArea()
                
                // scan start button
                Text("Start Scan")
                    .padding()
                    .font(.custom("Helvetica Neue", size: 33))
                    //.fontWeight(.medium)
                    .background(
                        Circle()
                            .frame(width: 220, height: 220)
                            .foregroundColor(Color("Green"))
                    )
                    .offset(y: -140)
                
                // scan status card
                VStack {
                    HStack {
                        Text("99%")
                            .padding(1)
                            .foregroundColor(Color.white)
                        Image("Battery")
                    }
                    
                    Text("Connected: 'WifiBot 0'")
                        .padding(1)
                        .foregroundColor(Color.white)
                    Text ("Ready to Scan")
                        .padding(5)
                        .foregroundColor(Color("Green"))
                }
                .font(.custom("Helvetica Neue", size: 23))
              //  .fontWeight(.medium)
                .offset(y: 125)
                .background(
                    RoundedRectangle(cornerSize: .init(width: 20, height: 20))
                        .frame(width: 300, height: 170)
                        .offset(y: 130)
                        .foregroundColor(Color("Gray"))
                )
                
                Divider()
                    .overlay(.white)
                    .frame(width: 500, height: 630, alignment: .bottom)
                
                // navbxdear
                HStack(spacing: 60) {
                    NavigationLink(destination: SettingsView())
                    {
                        Image("SettingsButton")
                    }
                    NavigationLink(destination: HomeView())
                    {
                        Image("ScanButtonActive")
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
