/*+===================================================================
File: LibraryView.swift

Summary: This page contains all existing wifi heat maps in a tile view. Maps can be clicked to open up a full view. Map tiles are able to edited / deleted / renamed from here.

===================================================================+*/


import SwiftUI

struct LibraryView: View {
    @State var isEditing: Bool = true
    @State var alertIsVisible: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                // background color
                Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                    .ignoresSafeArea()
                
                // placeholder text
                Text("WiFi Maps")
                    .font(.custom("Helvetica Neue", size: 26))
                    .foregroundColor(.white)
                    .frame(width:350, height: 725, alignment: .topLeading)
                
                Button(action: {
                    self.isEditing.toggle()
                }) {
                    Text(isEditing ? "Select" : "Done")
                        .font(.custom("Helvetica Neue", size: 26))
                        .frame(width:350, height: 725, alignment: .topTrailing)
                }
                
                Divider()
                    .frame(height: 1)
                    .overlay(Color.white)
                    .frame(width: 500, height: 630, alignment: .top)

                Button("Button") {
                    self.alertIsVisible = true
                }
                    .opacity(isEditing ? 0 : 1 )
                    .frame(width:350, height: 725, alignment: .center)
                
                Divider()
                    .overlay(.white)
                    .frame(width: 500, height: 630, alignment: .bottom)
                
                // navbar
                HStack(spacing: 60) {
                    NavigationLink(destination: SettingsView())
                    {
                        Image("SettingsButton")
                    }
                    NavigationLink(destination: HomeView())
                    {
                        Image("ScanButton")
                    }
                    NavigationLink(destination: LibraryView())
                    {
                        Image("MapLibraryButtonActive")
                    }
                }
                .frame(width: 500, height: 790, alignment: .bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
