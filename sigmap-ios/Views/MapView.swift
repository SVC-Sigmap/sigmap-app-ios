/*+===================================================================
File: MapView.swift

Summary: This page shows the full view of map tiles.

===================================================================+*/

import SwiftUI

struct MapView: View {
    let roomName: String
    var body: some View {
        Text(roomName)
        Text("Full View of Map Tile")
    }
}

struct MapView_Previews: PreviewProvider {
    
    @State static var roomName: String = "room 1"
    
    static var previews: some View {
        MapView(roomName: roomName)
    }
}

