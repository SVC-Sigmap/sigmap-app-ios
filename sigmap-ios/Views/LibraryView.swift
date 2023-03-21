/*+===================================================================
File: LibraryView.swift

Summary: This page contains all existing wifi heat maps in a tile view. Maps can be clicked to open up a full view. Map tiles are able to edited / deleted / renamed from here.

===================================================================+*/


import SwiftUI

struct LibraryView: View {
    @State var isEditing: Bool = true
    @State var alertIsVisible: Bool = false
    @State var renameBool: Bool = false
    @State var rename: Bool = false
    @State var roomNames = ["room 1", "room 2", "room 3", "room 4", "room 5", "room 6", "room 7", "room 8", "room 9", "room a", "room b", "room c", "room d"]
    @State var tempName = ""
    @State var testName = ""
    
    @State var currentlyEditing: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                // background color
                Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                    .ignoresSafeArea()
                
                if !currentlyEditing {
                    Text("WiFi Library")
                        .font(.custom("Helvetica Neue", size: 26))
                        .foregroundColor(.white)
                        .frame(width:350, height: 725, alignment: .topLeading)
                }
                
                Button(action: {
                    self.isEditing.toggle()
                    self.currentlyEditing = false
                    self.renameBool = false
                }) {
                    Text(isEditing ? "Select" : "Done")
                        .font(.custom("Helvetica Neue", size: 26))
                        .foregroundColor(.blue)
                        .frame(width:350, height: 725, alignment: .topTrailing)
                }
                
                Button("Rename") {
                    self.alertIsVisible = true
                    self.currentlyEditing = true
                    self.renameBool = false
                    self.rename = true
                }
                .opacity(renameBool ? 1 : 0 )
                .alert("Rename Heatmap", isPresented: $alertIsVisible) {
                    TextField("TextField", text: $testName)
                        .textInputAutocapitalization(.never)
                   Button("Rename") {
                       var j = 0
                       while j < roomNames.count {
                           if roomNames[j] == tempName {
                               roomNames.remove(at: j)
                               roomNames.insert(testName, at: j)
                           }
                           else {
                               j += 1
                           }
                       }
                       self.currentlyEditing.toggle()
                       self.isEditing.toggle()
                   }
                   Button("Cancel", role: .cancel, action: {})
               }
               .font(.custom("Helvetica Neue", size: 26))
               .foregroundColor(.blue)
               .frame(width:350, height: 725, alignment: .topLeading)
                
                Button("Delete") {
                    var i = 0
                    while i < roomNames.count {
                        if roomNames[i] == tempName {
                            roomNames.remove(at: i)
                        }
                        else {
                            i += 1
                        }
                    }
                    self.renameBool.toggle()
                    self.currentlyEditing.toggle()
                    self.isEditing.toggle()
                    }
                .opacity(renameBool ? 1 : 0 )
                .font(.custom("Helvetica Neue", size: 26))
                .foregroundColor(.red)
                .frame(width:350, height: 725, alignment: .top)
                
                VStack {
                    ScrollView {
                        VStack {
                            ForEach(roomNames, id: \.self) { roomName in
                                if isEditing {
                                    NavigationLink(destination: MapView(roomName: roomName)){
                                        VStack {
                                            Text(roomName)
                                                .font(.custom("Helvetica Neue", size: 50))
                                                .foregroundColor(.white)
                                                .frame(width: 350, alignment: .topLeading)
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
                
                Divider()
                    .overlay(.white)
                    .frame(width: 500, height: 650, alignment: .bottom)
            }
        }
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.all)
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
