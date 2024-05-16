//
//  AppVersionProvider.swift
//  RFIDAppNew
//
//  Created by RFID Lab on 5/16/24.
//

import Foundation

enum AppVersionProvider {
    static func appVersion(in bundle: Bundle = .main) -> String {
        guard let version = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            fatalError("CFBundleShortVersionString should not be missing from info dictionary")
        }
        return version
    }
}
