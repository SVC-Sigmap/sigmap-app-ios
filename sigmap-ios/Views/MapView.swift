/*+===================================================================
File: MapView.swift

Summary: This page shows the full view of map tiles.

===================================================================+*/

import SwiftUI

struct MapView: View {
    let roomName: String
    var body: some View {
        ZStack{
            // background color
            Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                .ignoresSafeArea()
            
            Text(roomName)
                .font(.custom("Helvetica Neue", size: 26))
                .foregroundColor(.white)
                .frame(width:350, height: 670, alignment: .topLeading)
            
            Divider()
                .frame(height: 1)
                .overlay(Color.white)
                .frame(width: 500, height: 600, alignment: .top)
            
            Image(roomName)
                .resizable(resizingMode: .stretch)
                .frame(width: 380.0, height: 600.0, alignment: .bottom)
                .offset(y: 10)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    
    @State static var roomName: String = "room 1"
    
    static var previews: some View {
        MapView(roomName: roomName)
    }
}

