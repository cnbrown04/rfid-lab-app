//
//  RFIDManager.swift
//  RFIDAppNew
//
//  Created by RFID Lab on 5/10/24.
//

import SwiftUI
import Combine

struct ReaderStruct: Identifiable, Hashable {
    let name: String
    let id: Int32
}

enum MemoryBank: UInt32, CaseIterable, Identifiable {
    case reserved = 0
    case epc = 1
    case tid = 2
    case user = 3
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .reserved:
            return "RESERVED - 0"
        case .epc:
            return "EPC - 1"
        case .tid:
            return "TID - 2"
        case .user:
            return "USER - 3"
        }
    }
}

class RFIDViewModel: ObservableObject {
    @Published var readers: [String] = []
    @Published var readerID: Int32 = 0
    @Published var tags: [String] = []
    let _api: srfidISdkApi = srfidSdkFactory.createRfidSdkApiInstance()
    @ObservedObject var apiDelegate: SdkApiDelegate
    
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
        observeTags()
    }
    
    private func observeTags() {
        apiDelegate.$tags
            .receive(on: DispatchQueue.main)
            .assign(to: &$tags)
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
    
    func connectToReader(reader: Int) -> Bool {
        let response = _api.srfidEstablishCommunicationSession(Int32(reader))
        if (response == SRFID_RESULT_SUCCESS) {
            readerID = Int32(reader)
            return true
        } else {
            return false
        }
    }
    
    func isActiveReader() -> Bool {
        return apiDelegate.isActiveReader
    }
    
    func startInventory(reader: String, memoryBank: MemoryBank, reportConfigArgs: [String: Bool], accessConfigArgs: [String: Any]) -> [String: Any] {
        var resp = SRFID_RESULT_FAILURE
        var statusMessage: NSString = ""

        guard let readerId = Int32(reader) else {
            return ["status": "failure", "message": "Invalid reader ID"]
        }

        let reportConfig = srfidReportConfig()
        configureReportConfig(reportConfig, with: reportConfigArgs)

        let accessConfig = srfidAccessConfig()
        configureAccessConfig(accessConfig, with: accessConfigArgs)

        let bank = SRFID_MEMORYBANK(memoryBank.rawValue)
        let __statusMessage = NSString()
        var _statusMessage = __statusMessage

        statusMessage = withUnsafeMutablePointer(to: &_statusMessage) { ptr -> NSString in
            let autoreleasePtr = AutoreleasingUnsafeMutablePointer<NSString?>(ptr)
            resp = _api.srfidStartInventory(readerId, aMemoryBank: bank, aReportConfig: reportConfig, aAccessConfig: accessConfig, aStatusMessage: autoreleasePtr)
            return __statusMessage
        }

        if resp == SRFID_RESULT_SUCCESS {
            return ["status": "success", "message": statusMessage]
        } else {
            return ["status": "failure", "message": statusMessage]
        }
    }
    
    func stopInventory(reader: String) -> [String: Any] {
        var resp = SRFID_RESULT_FAILURE
        var statusMessage: NSString = ""

        guard let readerId = Int32(reader) else {
            return ["status": "failure", "message": "Invalid reader ID"]
        }

        let __statusMessage = NSString()
        var _statusMessage = __statusMessage

        statusMessage = withUnsafeMutablePointer(to: &_statusMessage) { ptr -> NSString in
            let autoreleasePtr = AutoreleasingUnsafeMutablePointer<NSString?>(ptr)
            resp = _api.srfidStopInventory(readerId, aStatusMessage: autoreleasePtr)
            return __statusMessage
        }

        if resp == SRFID_RESULT_SUCCESS {
            return ["status": "success", "message": statusMessage]
        } else {
            return ["status": "failure", "message": statusMessage]
        }
    }

    private func configureReportConfig(_ reportConfig: srfidReportConfig, with args: [String: Bool]) {
        if let includeFirstSeenTime = args["includeFirstSeenTime"] {
            reportConfig.setIncFirstSeenTime(includeFirstSeenTime)
        }
        if let includePhase = args["includePhase"] {
            reportConfig.setIncPhase(includePhase)
        }
        if let includePC = args["includePC"] {
            reportConfig.setIncPC(includePC)
        }
        if let includeRSSI = args["includeRSSI"] {
            reportConfig.setIncRSSI(includeRSSI)
        }
        if let includeChannelIndex = args["includeChannelIndex"] {
            reportConfig.setIncChannelIndex(includeChannelIndex)
        }
        if let includeLastSeenTime = args["includeLastSeenTime"] {
            reportConfig.setIncLastSeenTime(includeLastSeenTime)
        }
        if let includeTagSeenCount = args["includeTagSeenCount"] {
            reportConfig.setIncTagSeenCount(includeTagSeenCount)
        }
    }

    private func configureAccessConfig(_ accessConfig: srfidAccessConfig, with args: [String: Any]) {
        if let doSelect = args["doSelect"] as? Bool {
            accessConfig.setDoSelect(doSelect)
        }
        if let power = args["power"] as? Int16 {
            accessConfig.setPower(power)
        }
    }
}

