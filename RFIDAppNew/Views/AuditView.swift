//
//  AuditView.swift
//  RFIDLabSwift
//
//  Created by RFID Lab on 5/9/24.
//

import Foundation
import SwiftUI

struct AuditView: View {
    @State private var storeArea: String = ""
    @State public var readUPC: Float = 0
    @ObservedObject var viewModel = RFIDViewModel()
    let memoryBank = MemoryBank.epc
    let reportConfigArgs: [String: Bool] = [
        "includeFirstSeenTime": true,
        "includePhase": true,
        "includePC": true,
        "includeRSSI": true,
        "includeChannelIndex": true,
        "includeLastSeenTime": true,
        "includeTagSeenCount": true
    ]
    let accessConfigArgs: [String: Any] = [
        "doSelect": true,
        "power": Int16(30)
    ]
    
    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            Text("Store Area")
            TextField("Click here", text: $storeArea)
                .textFieldStyle(.roundedBorder)
            
            Button("Read Tag") {
                
            }
        })
        .padding()
    }
}

#Preview {
    AnyView(AuditView())
}
