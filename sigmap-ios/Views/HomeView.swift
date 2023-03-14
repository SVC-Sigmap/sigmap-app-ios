/*+===================================================================
File: HomeView.swift

Summary: Serves as the home page of the Sigmap mobile app. Scans are able to started / stopped from here, and users are able to check the status and battery of their robot.

===================================================================+*/

import SwiftUI
import Foundation
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    @State var BatteryLevel: Int = 0
    @State var ConnectionStatus: String = ""
    @State var ScanReadiness: Bool = false
    
    struct res: Decodable {
        var Battery: Int = 0
        var Name: String = ""
        var Ready: Bool = false
        var Scanning: Bool = false
    }

    var body: some View {
            ZStack {
                // background color
                Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                    .frame(height: 1000)
                    .zIndex(-1)
                    .ignoresSafeArea()
                
                .onAppear {
                    // Create URL
                    let url = URL(string: "http://172.21.1.104:8080/api/status")
                    
                    guard let requestUrl = url else { fatalError() }
                    
                    // Create URL Request
                    var request = URLRequest(url: requestUrl)
                    
                    // Specify HTTP Method to use
                    request.httpMethod = "GET"
                    
                    // Send HTTP Request
                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        
                        // Check if Error took place
                        if let error = error {
                            print("Error took place \(error)")
                            return
                        }
                        
                        // Read HTTP Response Status code
                        if let response = response as? HTTPURLResponse {
                            print("Response HTTP Status code: \(response.statusCode)")
                        }
                        
                        // Convert HTTP Response Data to a simple String
                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
                            print("Response data string:\n \(dataString)")
                            let jsonResponse: res = try! JSONDecoder().decode(res.self, from: data)
                            print(jsonResponse.Battery)
                            print(jsonResponse.Name)
                            print(jsonResponse.Ready)
                            print(jsonResponse.Scanning)
                            BatteryLevel = jsonResponse.Battery
                            ConnectionStatus = jsonResponse.Name
                            ScanReadiness = jsonResponse.Ready
                        }
                    }
                    task.resume()
                }
                
                VStack {
                    Spacer()
                    Spacer()
                    // scan start button
                    Button {
                        Task {
                            // prepare json data
                            let json: [String: Any] = ["SIGMAP-CMD": "HallwayTravel"]

                            let jsonData = try? JSONSerialization.data(withJSONObject: json)
                            
                            // create post request
                            let url = URL(string: "http://172.21.1.104:8080/webhooks/cmd")!
                            var request = URLRequest(url: url)
                            request.httpMethod = "POST"
                            
                            // insert json data to the request
                            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                            request.httpBody = jsonData

                            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                                guard let data = data, error == nil else {
                                    print(error?.localizedDescription ?? "No data")
                                    return
                                }
                                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                                if let responseJSON = responseJSON as? [String: Any] {
                                    print(responseJSON)
                                }
                            }

                            task.resume()
                        }
                    } label: {
                        Text("Start Scan")
                            .padding()
                            .frame(width: 220, height: 220)
                            .contentShape(Circle())
                            .font(.custom("Helvetica Neue", size: 33))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .background(
                                Circle()
                                    .frame(width: 220, height: 220)
                                    .foregroundColor(Color.green)
                            )
                    }
                    .accessibilityLabel("startScanButton")
                
                    Spacer()
                    
                    // scan status card
                    VStack {
                        HStack {
                            Text(BatteryLevel != 0 ? String(BatteryLevel) + "%" : "No Battery Data")
                                .padding(1)
                                .foregroundColor(Color.white)
                            Image(BatteryLevel != 0 ? "Battery" : "NoBattery")
                        }
                        
                        Text(ConnectionStatus != "" ? "Connected: " + ConnectionStatus : "Device Not Connected")
                            .padding(1)
                            .foregroundColor(Color.white)
                        Text (ScanReadiness == true ? "Ready to Scan" : "Unable to Scan")
                            .padding(5)
                            .foregroundColor(ScanReadiness == true ? Color.green : Color.red)
                    }
                    .font(.custom("Helvetica Neue", size: 23))
                    .fontWeight(.medium)
                    .background(
                        RoundedRectangle(cornerSize: .init(width: 20, height: 20))
                            .frame(width: 330, height: 170)
                            .foregroundColor(Color.gray)
                    )
                    
                    Spacer()
                    Spacer()
                }
                
                Divider()
                    .overlay(.white)
                    .frame(width: 500, height: 650, alignment: .bottom)
            }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(FirestoreManager())
    }
}
