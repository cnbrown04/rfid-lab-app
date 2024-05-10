//
//  AccessoryManager.swift
//  RFIDAppNew
//
//  Created by RFID Lab on 5/10/24.
//

import ExternalAccessory
import Foundation

class AccessoryManager: NSObject {
    static let shared = AccessoryManager()
    private var accessoryManager: EAAccessoryManager

    override init() {
        accessoryManager = EAAccessoryManager.shared()
        super.init()
        observeAccessoryConnections()
    }

    // List all connected MFi devices
    func listConnectedMFiDevices() -> [EAAccessory] {
        print("RAN!")
        return accessoryManager.connectedAccessories
    }

    // Observe accessory connection changes
    private func observeAccessoryConnections() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(accessoryDidConnect), name: .EAAccessoryDidConnect, object: nil)
        notificationCenter.addObserver(self, selector: #selector(accessoryDidDisconnect), name: .EAAccessoryDidDisconnect, object: nil)
        
        accessoryManager.registerForLocalNotifications()
    }

    @objc private func accessoryDidConnect(notification: Notification) {
        guard let accessory = notification.userInfo?[EAAccessoryKey] as? EAAccessory else { return }
        print("Accessory Connected: \(accessory.name)")
        // Optionally handle the new connection
    }

    @objc private func accessoryDidDisconnect(notification: Notification) {
        guard let accessory = notification.userInfo?[EAAccessoryKey] as? EAAccessory else { return }
        print("Accessory Disconnected: \(accessory.name)")
        // Optionally handle the disconnection
    }

    // Clean up notifications when the accessory manager is no longer needed
    deinit {
        NotificationCenter.default.removeObserver(self)
        accessoryManager.unregisterForLocalNotifications()
    }
}

// Usage example:
// let accessoryManager = AccessoryManager.shared
// accessoryManager.listConnectedMFiDevices()
