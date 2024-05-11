//
//  RFIDManager.swift
//  RFIDAppNew
//
//  Created by RFID Lab on 5/10/24.
//

import SwiftUI
import Combine

class RFIDViewModel: ObservableObject {
    @Published var readers: [String] = []
    var apiInstance: srfidISdkApi = srfidSdkFactory.createRfidSdkApiInstance()

    func getAvailableReaderList() {
        var availableReaders: NSMutableArray? = NSMutableArray()
        apiInstance.srfidEnableAvailableReadersDetection(true)
        apiInstance.srfidSetOperationalMode(Int32(SRFID_OPMODE_MFI))
        apiInstance.srfidGetAvailableReadersList(&availableReaders)
        print(availableReaders)
        
        if let readers = availableReaders as? [srfidReaderInfo] {
            self.readers = readers.map { $0.getReaderName() }
        }
    }
}

