/*+===================================================================
 File: HomeView.swift
 
 Summary: Serves as the home page of the Sigmap mobile app. Scans are able to started / stopped from here, and users are able to check the status and battery of their robot.
 
 ===================================================================+*/

import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore

struct HomeView: View {
    
    // Backend API URL
    let API_URL: String = "http://172.21.1.112:8080"
    
    // Robot Status
    @State var BatteryLevel: Int = -1
    @State var ConnectionStatus: String = ""
    @State var ScanReadiness: Bool = false
    
    // Scan Data
    @State var isScanning: Bool = false
    @State var Strength: Double = 0
    @State var wifiData: [Double] = []
    @State var scanName: String = ""
    @State var presentAlert: Bool = false
    @State var displayedWifiStrength: Int = 0
    
    // Timer configuration
    @State var timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    // GET request JSON structure definition for Robot status info
    struct res: Decodable {
        var Battery: Int = 0
        var Name: String = ""
        var Ready: Bool = false
        var Scanning: Bool = false
    }
    
    // GET request JSON structure definition for Wifi strength data
    struct wifi_res: Decodable {
        var link_quality: Double = 0
    }
    
    var body: some View {
        ZStack {
            // Background color
            Color(UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
                .frame(height: 1000)
                .zIndex(-1)
                .ignoresSafeArea()
            
            // Update status card on startup
            .onAppear {
                getRobotStatus()
            }
            
            VStack {
                
                Spacer()
                Spacer()
                
                // Start / stop scan button
                Button {
                    Task {
                        // Enable robot movement via controller
                        startTeleopJoystick()
                        
                        // Show scan name pop-up when scan is stopped
                        if isScanning {
                            timer.upstream.connect().cancel()
                            presentAlert.toggle()
                        }
                        
                        // Update scan state when button is pressed
                        isScanning.toggle()
                    }
                } label: {
                    // Render 'Stop Scan' button when scan is in progress
                    isScanning ?
                    Text("Stop Scan")
                        .padding()
                        .frame(width: 220, height: 220)
                        .contentShape(Circle())
                        .font(.custom("Helvetica Neue", size: 33))
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .background(
                            Circle()
                                .frame(width: 220, height: 220)
                                .foregroundColor(Color.red)
                        )
                    :
                    // Render 'Start Scan' button when not scanning
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
                
                // Render live Wifi strength data when scan is in progress
                if isScanning {
                    Text("WiFi Strength: \(displayedWifiStrength)")
                        .onReceive(timer) { firedDate in
                            let data = getWifiData()
                            displayedWifiStrength = Int(data)
                            wifiData.append(data)
                        }
                        .padding(.top, 60)
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                Spacer()
                
                // scan status card
                VStack {
                    // Battery status
                    HStack {
                        Text(BatteryLevel >= 0 ? String(BatteryLevel) + "%" : "No Battery Data")
                            .padding(1)
                            .foregroundColor(Color.white)
                        Image(BatteryLevel >= 0 ? "Battery" : "NoBattery")
                    }
                    
                    // Robot connection status
                    Text(ConnectionStatus != "" ? "Connected: " + ConnectionStatus : "Device Not Connected")
                        .padding(1)
                        .foregroundColor(Color.white)
                    
                    // Robot readiness data
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
        
        // Render scan name input pop-up when scan is stopped
        .alert("Scan Name", isPresented: $presentAlert, actions: {
            let computedWifiData = computeData(dataArr: wifiData)
            TextField("Scan Name", text: $scanName)
            Button("Enter", action: {createScan(ScanName: scanName, Average: computedWifiData[0] ?? 0, Min: computedWifiData[1] ?? 0, Max: computedWifiData[2] ?? 0)})
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            Text("Please enter the name of the scan")
        })
    }
    
    // GET request to the API for Wifi signal strength data
    func getWifiData() -> Double {

        // Create URL
        let url = URL(string: API_URL + "/api/signal")
        
        guard let requestUrl = url else { fatalError() }
        
        // Create URL request
        var request = URLRequest(url: requestUrl)
        
        // Specify HTTP method
        request.httpMethod = "GET"
        
        // Send HTTP request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Error handling
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Decode HTTP response data
            if let data = data {
                let jsonResponse: wifi_res = try! JSONDecoder().decode(wifi_res.self, from: data)
                print(jsonResponse.link_quality)
                Strength = jsonResponse.link_quality
            }
        }
        task.resume()
        return Strength
    }
    
    // POST request to API to enable robot movement via PS4 controller
    func startTeleopJoystick() -> Void {
        
        // Prepare JSON request body
        let json: [String: Any] = ["SIGMAP-CMD": "Teleoperation_Joystick"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // Create POST URL
        let url = URL(string: API_URL + "/webhooks/cmd")!
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Attach JSON data to the request body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Send POST request to API
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
    
    // GET request to the API for robot status information
    func getRobotStatus() -> Void {
        
        // Create URL
        let url = URL(string: API_URL + "/api/status")
        
        guard let requestUrl = url else { fatalError() }
        
        // Create URL request
        var request = URLRequest(url: requestUrl)
        
        // Specify HTTP method
        request.httpMethod = "GET"
        
        // Send HTTP request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Error handling
            if let error = error {
                print("Error took place \(error)")
                BatteryLevel = -1
                ConnectionStatus = ""
                ScanReadiness = false
                return
            }
            
            // Decode HTTP response data
            if let data = data {
                let jsonResponse: res = try! JSONDecoder().decode(res.self, from: data)
                BatteryLevel = jsonResponse.Battery
                ConnectionStatus = jsonResponse.Name
                ScanReadiness = jsonResponse.Ready
            }
        }
        task.resume()
    }
    
    // Define a new scan document in Firestore for the active user and upload wifi data
    func createScan(ScanName: String, Average: Int, Min: Int, Max: Int) -> Void {
        
        // Connect to Firestore
        let db = Firestore.firestore()
        
        // Create a new document called <ScanName> in the active user's collection
        let docRef = db.collection("Test@test.com").document(ScanName)
        
        // Scan data object definition
        let docData: [String: Int] = [
            "Average": Average,
            "Min": Min,
            "Max": Max,
        ]
        
        // Upload scan data to newly created document in Firestore
        docRef.setData(docData) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    // Return the average, min, and max of an array - return zeroes if empty
    func computeData(dataArr: [Double]) -> [Int?] {
        if (dataArr.isEmpty) {
            return [0, 0, 0]
        } else {
            // Remove all zeros from the array
            let filteredArr = dataArr.filter({$0 > 0})
            
            let sum = filteredArr.reduce(0, +)
            let average = Int(Int(sum) / Int(filteredArr.count))
            let minimum = Int(filteredArr.min() ?? 0)
            let maximum = Int(filteredArr.max() ?? 0)
            
            let returnArr = [average, minimum, maximum]
            
            return returnArr
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
