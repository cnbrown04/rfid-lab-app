//
//  SettingsView.swift
//  RFIDLabSwift
//
//  Created by RFID Lab on 5/9/24.
//

import Foundation
import SwiftUI

/*class ScannerSDK {
    let apiInstance: ISbtSdkApi
    
    init() {
        apiInstance = SbtSdkFactory.createSbtSdkApiInstance()
        apiInstance.sbtSetOperationalMode(2) // ALL
        //apiInstance.sbtEnableAvailableScannersDetection(true)
        //apiInstance.sbtEnableBluetoothScannerDiscovery(true)
        
    }
    
    func subscribeToEvents() {
        
        let eventsMask = SBT_EVENT_SCANNER_APPEARANCE
        
        let result = apiInstance.sbtSubsribe(forEvents: Int32(eventsMask))
        if (result) == SBT_RESULT_SUCCESS {
            print("SUCKSESS!")
        } else {
            print("YOU SUCK!")
        }
    }
    
    func checkVersion() {
        if let version = apiInstance.sbtGetVersion() {
            print("Zebra SDK version: \(version)")
        }
    }
    
    func getAvailableScanners() {
        var availableScannersList: NSMutableArray? = NSMutableArray()
        var activeScannersList: NSMutableArray? = NSMutableArray()
        let result = apiInstance.sbtGetAvailableScannersList(&availableScannersList)
        let result2 = apiInstance.sbtGetActiveScannersList(&activeScannersList)
        
        switch result {
        case SBT_RESULT_SUCCESS:
            if let scanners = availableScannersList { // Assuming ScannerInfo is a model class that represents scanners
                print("SCANNERS \(scanners)")
                for scanner in scanners {
                    print("Scanner found: \(scanner)") // Adjust 'description' based on your model properties
                }
            }
        default:
            print("Failed to get available scanners with error code: \(result)")
        }
        
        switch result2 {
        case SBT_RESULT_SUCCESS:
            if let scanners = activeScannersList { // Assuming ScannerInfo is a model class that represents scanners
                print("SCANNERS \(scanners)")
                for scanner in scanners {
                    print("Scanner found: \(scanner)") // Adjust 'description' based on your model properties
                }
            }
        default:
            print("Failed to get active scanners with error code: \(result)")
        }
    }
}*/

struct SettingsView: View {
    @State private var scannerIndex = 0
    let listener = Listener()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("SCANNER OPTIONS"), content: {
                    Button("Load Scanners") {
                        //scannerSDK.getAvailableScanners()
                    }
                    HStack {
                        Image(systemName: "qrcode.viewfinder")
                        Picker(selection: $scannerIndex, label: Text("Scanner")) {
                            // Populate Picker dynamically based on scans
                            Text("y")
                        }
                    }
                })
            }
        }
        .navigationBarTitle("Settings")
    }
}
//#Preview {
//    AnyView(SettingsView())
//}
