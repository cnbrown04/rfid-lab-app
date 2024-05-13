//
//  RFIDManager.swift
//  RFIDAppNew
//
//  Created by RFID Lab on 5/10/24.
//

import SwiftUI
import Combine

struct ReaderStruct: Identifiable {
    let name: String
    let id: Int32
}

class RFIDViewModel: ObservableObject {
    @Published var readers: [String] = []
    let _api: srfidISdkApi = srfidSdkFactory.createRfidSdkApiInstance()
    let apiDelegate: SdkApiDelegate
    
    init() {
        self.apiDelegate = SdkApiDelegate(api: _api)
        
        _api.srfidSetOperationalMode(Int32(SRFID_OPMODE_ALL))
        _api.srfidSubsribe(forEvents: Int32(SRFID_EVENT_READER_APPEARANCE) | Int32(SRFID_EVENT_READER_DISAPPEARANCE) | Int32(SRFID_EVENT_SESSION_ESTABLISHMENT) | Int32(SRFID_EVENT_SESSION_TERMINATION))
        _api.srfidSubsribe(forEvents: Int32(SRFID_EVENT_MASK_READ) | Int32(SRFID_EVENT_MASK_STATUS) | Int32(SRFID_EVENT_MASK_STATUS_OPERENDSUMMARY))
        _api.srfidSubsribe(forEvents: Int32(SRFID_EVENT_MASK_TEMPERATURE) | Int32(SRFID_EVENT_MASK_POWER) | Int32(SRFID_EVENT_MASK_DATABASE))
        _api.srfidSubsribe(forEvents: Int32(SRFID_EVENT_MASK_PROXIMITY) | Int32(SRFID_EVENT_MASK_TRIGGER) | Int32(SRFID_EVENT_MASK_BATTERY))
        _api.srfidEnableAvailableReadersDetection(true)
        _api.srfidEnableAutomaticSessionReestablishment(true)
        _api.srfidSetDelegate(self.apiDelegate)
    }

    func getAvailableReaderList() -> [ReaderStruct] {
        let devices: NSMutableArray = NSMutableArray()
        var _devices = devices
        apiDelegate.availableReaders = withUnsafeMutablePointer(to: &_devices) { ptr -> Array<srfidReaderInfo>? in
            let devicesPtr : AutoreleasingUnsafeMutablePointer<NSMutableArray?> = AutoreleasingUnsafeMutablePointer<NSMutableArray?>.init(ptr)
            let r = _api.srfidGetAvailableReadersList(devicesPtr)
            if r == SRFID_RESULT_SUCCESS {
                return (devices.map({ obj in
                    obj as! srfidReaderInfo
                }))
            }
            else {
                print("Unable to get available readers")
            }
            print("nil")
            return nil
        }
        return apiDelegate.availableReaders!.map({ (reader: srfidReaderInfo) -> ReaderStruct in
            return ReaderStruct(name: reader.getReaderName(), id: reader.getReaderID())
        })
    }
}

