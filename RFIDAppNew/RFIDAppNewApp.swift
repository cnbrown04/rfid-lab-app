//
//  RFIDAppNewApp.swift
//  RFIDAppNew
//
//  Created by RFID Lab on 5/9/24.
//

import SwiftUI

@main
struct RFIDAppNewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class Listener: NSObject, ISbtSdkApiDelegate {
    let apiInstance: ISbtSdkApi
    
    override init() {
        print("Initializing API...")
        apiInstance = SbtSdkFactory.createSbtSdkApiInstance()
        super.init()
        
        if apiInstance.sbtGetVersion() == nil {
            print("Failed to create API.")
        } else {
            print("API created sucessfully.")
        }
        
        let eventsMask = SBT_EVENT_SCANNER_APPEARANCE
        
        apiInstance.sbtSetDelegate(self)
        let result = apiInstance.sbtSubsribe(forEvents: Int32(eventsMask))
        if (result == SBT_RESULT_SUCCESS) {
            print("API sucessfully subscribed to Scanner Appearances.")
        } else {
            print("Failed to subscribe to Scanner Appearance events.")
        }
    }
    
    func sbtEventScannerAppeared(_ availableScanner: SbtScannerInfo!) {
        print("WAT")
        if let scanner = availableScanner {
            // Access properties like scannerID or model number as needed
            print("A lil scanner baby appeared: Model \(scanner.getScannerModel()), ID \(scanner.getScannerID())")
        } else {
            print("A lil scanner baby appeared, but scanner info is not available.")
        }
    }
    
    func sbtEventScannerDisappeared(_ scannerID: Int32) {
        print("Scanner with ID \(scannerID) has disappeared.")
    }
    
    func sbtEventCommunicationSessionEstablished(_ activeScanner: SbtScannerInfo!) {
        
    }
    
    func sbtEventCommunicationSessionTerminated(_ scannerID: Int32) {
        
    }
    
    func sbtEventBarcode(_ barcodeData: String!, barcodeType: Int32, fromScanner scannerID: Int32) {

    }
    
    func sbtEventBarcodeData(_ barcodeData: Data!, barcodeType: Int32, fromScanner scannerID: Int32) {
        
    }
    
    func sbtEventFirmwareUpdate(_ fwUpdateEventObj: FirmwareUpdateEvent!) {
        
    }
    
    func sbtEventImage(_ imageData: Data!, fromScanner scannerID: Int32) {
        
    }
    
    func sbtEventVideo(_ videoFrame: Data!, fromScanner scannerID: Int32) {
        
    }
    
    
    
}
