//
//  DelegateHandler.swift
//  RFIDAppNew
//
//  Created by RFID Lab on 5/13/24.
//

import Foundation

class SdkApiDelegate: NSObject, ObservableObject, srfidISdkApiDelegate {
    let api: srfidISdkApi
    var availableReaders: Array<srfidReaderInfo>?
    var activeReaders: Array<srfidReaderInfo>?
    @Published var isActiveReader = false
    @Published var tags: [String] = []
    
    init(api: srfidISdkApi) {
        self.api = api
    }
    
    func srfidEventReaderAppeared(_ availableReader: srfidReaderInfo!) {
        
    }
    
    func srfidEventReaderDisappeared(_ readerID: Int32) {
        
    }
    
    func srfidEventCommunicationSessionEstablished(_ activeReader: srfidReaderInfo!) {
        if let reader = self.availableReaders?.first(where: { $0.getReaderID() == activeReader.getReaderID()}) {
            reader.setActive(true)
        }
        let resp = self.api.srfidEstablishAsciiConnection(activeReader.getReaderID(), aPassword: nil)
        if resp == SRFID_RESULT_SUCCESS {
            self.api.srfidSetBeeperConfig(activeReader.getReaderID(), aBeeperConfig: SRFID_BEEPERCONFIG_QUIET, aStatusMessage: nil)
        }
        isActiveReader = true
    }
    
    func srfidEventCommunicationSessionTerminated(_ readerID: Int32) {
        isActiveReader = false
    }
    
    func srfidIsActiveReader() -> Bool! {
        return isActiveReader
    }
    
    func srfidEventReadNotify(_ readerID: Int32, aTagData tagData: srfidTagData!) {
        // This method is called when a tag is read
        if let tagId = tagData.getTagId() {
            DispatchQueue.main.async {
                self.tags.append(tagId)
            }
        }
        print(tags)
    }
    
    func srfidEventStatusNotify(_ readerID: Int32, aEvent event: SRFID_EVENT_STATUS, aNotification notificationData: Any!) {
        
    }
    
    func srfidEventProximityNotify(_ readerID: Int32, aProximityPercent proximityPercent: Int32) {
        
    }
    
    func srfidEventMultiProximityNotify(_ readerID: Int32, aTagData tagData: srfidTagData!) {
        
    }
    
    func srfidEventTriggerNotify(_ readerID: Int32, aTriggerEvent triggerEvent: SRFID_TRIGGEREVENT) {
        
    }
    
    func srfidEventBatteryNotity(_ readerID: Int32, aBatteryEvent batteryEvent: srfidBatteryEvent!) {
        
    }
    
    func srfidEventWifiScan(_ readerID: Int32, wlanSCanObject wlanScanObject: srfidWlanScanList!) {
        
    }
    
    func clearTags() {
        tags = []
    }
    
}
