//
//  FirebaseManager.swift
//  sigmap-ios
//
//  Created by Jack Puschnigg on 2023-02-23.
//

import Foundation
import Firebase

class FirestoreManager: ObservableObject {
    @Published var temp: String = ""
    
    init() {
        fetch()
    }
    
    func fetchAll() {
            let db = Firestore.firestore()

            db.collection("test").getDocuments() { (querySnapshot, error) in
                            if let error = error {
                                    print("Error getting documents: \(error)")
                            } else {
                                    for document in querySnapshot!.documents {
                                            print("\(document.documentID): \(document.data())")
                                    }
                            }
            }
    }
    
    func fetch() {
        let db = Firestore.firestore()

        let docRef = db.collection("test").document("op7w2FHQIzgKskBSNvu4")

        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    self.temp = data["name"] as? String ?? ""
                }
            }

        }
    }
}
