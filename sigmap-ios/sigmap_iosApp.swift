/*+===================================================================
File: sigmap_iosApp.swift

===================================================================+*/

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct sigmap_iosApp: App {
    @StateObject var firestoreManager = FirestoreManager()
    @State var isLoggedIn: Bool = false

    init() {
        FirebaseApp.configure()
    }

  var body: some Scene {
    WindowGroup {
      NavigationView {
          if !isLoggedIn {
              LoginView(isLoggedIn: $isLoggedIn)
          } else {
              HomeView()
                  .environmentObject(firestoreManager)
          }
      }
    }
  }
}
