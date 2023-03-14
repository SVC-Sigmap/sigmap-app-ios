//
//  LoginView.swift
//  sigmap-ios
//
//  Created by Jack Puschnigg on 2023-02-27.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @Binding var isLoggedIn: Bool

    var body: some View {
        ZStack {
            // background color
            Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("SigMap")
                    .font(.custom("Helvetica Neue", size: 52))
                    .foregroundColor(Color.gray)
                Image("ScanButtonActive")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding([.bottom], 30)
                TextField("   Email", text: $email)
                    .accessibilityLabel("loginEmail")
                    .foregroundColor(Color.black)
                    .frame(width: 300, height: 30)
                    .background(RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white))
                        .padding([.bottom], 15)
                SecureField("   Password", text: $password)
                    .accessibilityLabel("loginPassword")
                    .foregroundColor(Color.black)
                    .frame(width: 300, height: 30)
                    .background(RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white))
                        .padding([.bottom], 15)
                Button(action: { login() }) {
                    Text("Sign in")
                        .foregroundColor(Color.black)
                        .background(
                            RoundedRectangle(cornerRadius: 100)
                                .fill(Color.gray)
                                .frame(width: 100, height: 40)
                        )
                }
                .accessibilityLabel("loginButton")
                .padding([.top], 15)
                Spacer()
            }
            .padding()
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                isLoggedIn = true
            }
        }
    }
}
