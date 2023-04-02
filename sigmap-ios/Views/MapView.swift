/*+===================================================================
File: MapView.swift

Summary: This page shows the full view of map tiles.

===================================================================+*/

import SwiftUI
import FirebaseFirestore

struct MapView: View {
    let roomName: String

    @State var scanMin: Int = 0
    @State var scanMax: Int = 0
    @State var scanAverage: Int = 0
    
    var body: some View {
        ZStack{
            // background color
            Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                .ignoresSafeArea()
            
                .onAppear {
                    fetchScanData()
                }
            
            Text(roomName)
                .font(.custom("Helvetica Neue", size: 26))
                .foregroundColor(.white)
                .frame(width:350, height: 725, alignment: .topLeading)
            
            Divider()
                .frame(height: 1)
                .overlay(Color.white)
                .frame(width: 500, height: 630, alignment: .top)
            
            VStack{
                Text("Min: " + String(scanMin))
                    .font(.custom("Helvetica Neue", size: 22))
                    .foregroundColor(.white)
                    .frame(width: 350, alignment: .topLeading)
                Text("Average: " + String(scanAverage))
                    .font(.custom("Helvetica Neue", size: 22))
                    .foregroundColor(.white)
                    .frame(width: 350, alignment: .topLeading)
                Text("Max: " + String(scanMax))
                    .font(.custom("Helvetica Neue", size: 22))
                    .foregroundColor(.white)
                    .frame(width: 350, alignment: .topLeading)
            }
        }
    }
    
    func fetchScanData() {
        let db = Firestore.firestore()

        let docRef = db.collection("Test@test.com").document(roomName)
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    scanMin = data["Min"] as! Int
                    scanMax = data["Max"] as! Int
                    scanAverage = data["Average"] as! Int
                }
            }

        }
    }
}

struct MapView_Previews: PreviewProvider {
    
    @State static var roomName: String = "room 1"
    
    static var previews: some View {
        MapView(roomName: roomName)
    }
}

