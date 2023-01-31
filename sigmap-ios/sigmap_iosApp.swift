/*+===================================================================
File: sigmap_iosApp.swift

===================================================================+*/

import SwiftUI
import Firebase

@main
struct sigmap_iosApp: App {
    
  init() {
    FirebaseApp.configure()
  }
    
  var body: some Scene {
    WindowGroup {
      NavigationView {
          HomeView()
      }
    }
  }
}
