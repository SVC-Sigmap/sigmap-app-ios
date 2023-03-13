/*+===================================================================
File: LibraryView.swift

Summary: This page contains all existing wifi heat maps in a tile view. Maps can be clicked to open up a full view. Map tiles are able to edited / deleted / renamed from here.

===================================================================+*/


import SwiftUI

struct LibraryView: View {
    @State var isEditing: Bool = true
    @State var alertIsVisible: Bool = false
    @State var editingMap: Bool = false
    @State var renameBool: Bool = false
    @State var rename: Bool = false
    @State var roomNames = ["room 1", "room 2", "room 3", "room 4", "room 5", "room 6", "room 7"]
    @State var tempName = ""
    @State var testName = ""
    
    private var columns = Array(repeating: GridItem(.flexible(), spacing: -100), count: 2)
    
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        }

    var body: some View {
        NavigationView {
            ZStack {
                // background color
                Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                    .ignoresSafeArea()
                
                if !editingMap {
                    Text("WiFi Maps")
                        .font(.custom("Helvetica Neue", size: 26))
                        .foregroundColor(.white)
                        .frame(width:350, height: 725, alignment: .topLeading)
                }
                
                Button(action: {
                    self.isEditing.toggle()
                    self.editingMap = false
                    self.renameBool = false
                }) {
                    Text(isEditing ? "Select" : "Done")
                        .font(.custom("Helvetica Neue", size: 26))
                        .frame(width:350, height: 725, alignment: .topTrailing)
                }

                Button("Rename") {
                    self.alertIsVisible = true
                    self.editingMap = true
                    self.renameBool = false
                    self.rename = true
                    }
                .opacity(renameBool ? 1 : 0 )
                .alert("Rename Heatmap", isPresented: $alertIsVisible,
                       actions: {
                    TextField("TextField", text: $testName)
                })
                .font(.custom("Helvetica Neue", size: 26))
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
                    }
                .opacity(renameBool ? 1 : 0 )
                .font(.custom("Helvetica Neue", size: 26))
                .foregroundColor(.red)
                .frame(width:350, height: 725, alignment: .top)
                
                VStack (spacing: 10) {
                    ScrollView(){
                        LazyVGrid(columns: columns) {
                            ForEach(roomNames, id: \.self) { roomName in
                                HStack{
                                    VStack{
                                        if isEditing {
                                            NavigationLink(destination: MapView(roomName: roomName)){
                                                Image(systemName: "square.fill")
                                                    .font(.system(size: 150))
                                                    .foregroundColor(.white)
                                            }
                                            Text(roomName)
                                                .foregroundColor(Color.white)
                                        }
                                        else {
                                            Button(action: {
                                                self.renameBool.toggle()
                                                self.editingMap = true
                                                tempName = roomName
                                                
                                                //print("Room Count: \(roomNames.count)")
                                                
                                                var i = 0
                                                //print("Rename: \(rename)")
                                                if rename == true {
                                                    print("Rename if true: \(rename)")
                                                    while i < roomNames.count {
                                                        //print("roomNames[i]: \(roomNames[i])")
                                                        //print("tempName: \(tempName)")
                                                        //print("testName: \(testName)")
                                                        if roomNames[i] == tempName {
                                                            roomNames[i] = testName
                                                            //print(roomNames[i])
                                                        }
                                                        else {
                                                            i += 1
                                                        }
                                                    }
                                                }

                                            }) {
                                                Image(systemName: "circle")
                                                    .font(.system(size: 10))
                                                    .foregroundColor(.blue)
                                                    .padding(60)
                                            }
                                            .background(
                                                Image(systemName: "square.fill")
                                                    .font(.system(size: 150))
                                                    .foregroundColor(.white))
                                            Text(roomName)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                }
                            }
                        }
                    }.padding(.top, 100).padding(.bottom, 100)
                }

                    
                Divider()
                    .frame(height: 1)
                    .overlay(Color.white)
                    .frame(width: 500, height: 630, alignment: .top)
                
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
