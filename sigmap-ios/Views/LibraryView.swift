/*+===================================================================
File: LibraryView.swift

Summary: This page contains all existing wifi heat maps in a tile view. Maps can be clicked to open up a full view. Map tiles are able to edited / deleted / renamed from here.

===================================================================+*/


import SwiftUI
import FirebaseFirestore

struct LibraryView: View {
    @State var isEditing: Bool = true
    @State var alertIsVisible: Bool = false
    @State var renameBool: Bool = false
    @State var rename: Bool = false
    @State var tempName = ""
    @State var testName = ""
    
    @State var roomNames: [String] = []
    
    @State var currentlyEditing: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                // background color
                Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                    .ignoresSafeArea()
                
                    .onAppear {
                        fetchAllScans()
                    }
                
                Text("WiFi Library")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .frame(width:350, height: 725, alignment: .top)
                    .offset(y: 10)
                    .offset(x: -10)
                
                VStack {
                    List(roomNames, id: \.self) { roomName in
                        NavigationLink(destination: MapView(roomName: roomName)){
                            VStack {
                                HStack {
                                    Text(roomName)
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                        .frame(width: 320, alignment: .topLeading)
                                }
                            }
                        }
                        .swipeActions {
                                Button {
                                    deleteScan(scanName: roomName)
                                    fetchAllScans()
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                        }
                    }
                }
                .frame(width: 400, height: 630, alignment: .top)
                .offset(y: 10)

                Divider()
                    .frame(height: 1)
                    .overlay(Color.white)
                    .frame(width: 500, height: 630, alignment: .top)
                    .padding(.bottom, -20)
                
                Divider()
                    .overlay(.white)
                    .frame(width: 500, height: 650, alignment: .bottom)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func fetchAllScans() {
        let db = Firestore.firestore()
        
        roomNames = []

        db.collection("user@gmail.com").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    roomNames.append(document.documentID)
                }
            }
        }
    }
    
    func deleteScan(scanName: String) {
        let db = Firestore.firestore()
    
        db.collection("user@gmail.com").document(scanName).delete() { err in
            if let err = err {
                print("Error deleting document: \(err)")
            } else {
                print("\(scanName) successfully deleted!")
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
