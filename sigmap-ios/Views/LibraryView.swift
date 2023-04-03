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
//    @State var roomNames = ["room 1", "room 2", "room 3", "room 4", "room 5", "room 6", "room 7", "room 8", "room 9", "room a", "room b", "room c", "room d"]
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
                    .font(.custom("Helvetica Neue", size: 30))
                    .foregroundColor(.white)
                    .frame(width:350, height: 725, alignment: .top)
                    .offset(y: 10)
                    .offset(x: -10)
                
                VStack {
                    ScrollView {
                        VStack {
                            ForEach(roomNames, id: \.self) { roomName in
                                if isEditing {
                                    NavigationLink(destination: MapView(roomName: roomName)){
                                        VStack {
                                            HStack {
                                                Text(roomName)
                                                    .font(.custom("Helvetica Neue", size: 30))
                                                    .foregroundColor(.white)
                                                    .frame(width: 350, alignment: .topLeading)
                                                
                                                Image(systemName: "chevron.right")
                                                    .resizable()
                                                    .frame(width: 10, height: 20)
                                                    .font(Font.system(.footnote).weight(.semibold))
                                                    .foregroundColor(.white)
                                            }
                                            .padding(-1)
                                            Divider()
                                                .overlay(.white)
                                            
                                        }
                                    }
                                }
                                else {
                                    VStack {
                                        HStack{
                                            Text(roomName)
                                                .font(.custom("Helvetica Neue", size: 50))
                                                .foregroundColor(.white)
                                                .frame(width: 322, alignment: .topLeading)
                                            
                                            Button(action: {
                                                self.currentlyEditing = true
                                                self.renameBool = true
                                                tempName = roomName
                                            }) {
                                                    if !currentlyEditing {
                                                    Image(systemName: "circle")
                                                        .foregroundColor(.blue)
                                                        .frame(alignment: .topLeading)
                                                    }
                                                    else {
                                                    if tempName == roomName {
                                                        Image(systemName: "circle.fill")
                                                            .foregroundColor(.blue)
                                                            .frame(alignment: .topLeading)
                                                    }
                                                    else {
                                                        Image(systemName: "circle")
                                                            .foregroundColor(.blue)
                                                            .frame(alignment: .topLeading)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                }
                .frame(width: 395, height: 600, alignment: .top)

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
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.all)
    }
    
    func fetchAllScans() {
        let db = Firestore.firestore()
        
        roomNames = []

        db.collection("Test@test.com").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    print(document.documentID)
                    roomNames.append(document.documentID)
                }
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
