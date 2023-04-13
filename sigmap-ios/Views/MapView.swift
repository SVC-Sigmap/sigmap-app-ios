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
            Color(.black)
                .ignoresSafeArea()
            
                .onAppear {
                    fetchScanData()
                }
            
            Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                .frame(height: 300)
                .offset(y: -434)
                .ignoresSafeArea()
            
            Text(roomName)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .frame(width:350, height: 670, alignment: .top)
            
            Divider()
                .frame(height: 1)
                .overlay(Color.white)
                .frame(width: 500, height: 600, alignment: .top)
                .padding(.top, 30)
            
            VStack{
                Text("Min: " + String(scanMin))
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .frame(width: 350, alignment: .top)
                    .padding()
                Text("Average: " + String(scanAverage))
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .frame(width: 350, alignment: .top)
                    .padding()
                Text("Max: " + String(scanMax))
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .frame(width: 350, alignment: .top)
                    .padding()
            }
            .background(
                RoundedRectangle(cornerSize: .init(width: 30, height: 20))
                    .frame(width: 200, height: 270)
                    .foregroundColor(Color.gray)
            )
            
            Divider()
                .overlay(.white)
                .frame(width: 500, height: 605, alignment: .bottom)
            
            Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                .frame(height: 300)
                .offset(y: 453)
                .ignoresSafeArea()
        }
    }
    
    func fetchScanData() {
        let db = Firestore.firestore()

        let docRef = db.collection("user@gmail.com").document(roomName)
        
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
    
    @State static var roomName: String = "Living room"
    
    static var previews: some View {
        MapView(roomName: roomName, scanMin: 86, scanMax: 98, scanAverage: 94)
    }
}

