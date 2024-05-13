//
//  DelegateHandler.swift
//  RFIDAppNew
//
//  Created by RFID Lab on 5/13/24.
//

import Foundation

class SdkApiDelegate: NSObject, srfidISdkApiDelegate {
    func srfidEventReaderAppeared(_ availableReader: srfidReaderInfo!) {
        
    }
    
    func srfidEventReaderDisappeared(_ readerID: Int32) {
        
    }
    
    func srfidEventCommunicationSessionEstablished(_ activeReader: srfidReaderInfo!) {
        
    }
    
    func srfidEventCommunicationSessionTerminated(_ readerID: Int32) {
        
    }
    
    func srfidEventReadNotify(_ readerID: Int32, aTagData tagData: srfidTagData!) {
        
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
    
    let api: srfidISdkApi
    var availableReaders: Array<srfidReaderInfo>?
    var activeReaders: Array<srfidReaderInfo>?
    
    init(api: srfidISdkApi) {
        self.api = api
    }
}
