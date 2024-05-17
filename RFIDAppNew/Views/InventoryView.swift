//
//  InventoryView.swift
//  RFIDAppNew
//
//  Created by RFID Lab on 5/16/24.
//

import Foundation
import SwiftUI

struct InventoryView: View {
    @StateObject var viewModel = RFIDViewModel()
    @State var scanFor: MemoryBank = .epc
    @State var scanning = false
    
    var body: some View {
        let sanitizedData = Array(Set(viewModel.apiDelegate.tags))
        VStack {
            List(sanitizedData, id: \.self) { tag in
                Text(tag)
            }
            .overlay(Group {
                if (viewModel.apiDelegate.tags.isEmpty) {
                    Text("Start scanning to get started.")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            })
            
            HStack {
                Picker("Scan for:", selection: $scanFor) {
                    ForEach(MemoryBank.allCases) { option in
                        Text(String(describing: option))
                    }
                }
                .pickerStyle(.segmented)
            }.padding(.horizontal)
            HStack {
                
                if (!scanning) {
                    Button("Start Scanning") {
                        scanning = true
                        let reader = "1"
                        let memoryBank = scanFor // Use the appropriate memory bank
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
                        
                        let result = viewModel.startInventory(reader: reader, memoryBank: memoryBank, reportConfigArgs: reportConfigArgs, accessConfigArgs: accessConfigArgs)
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                } else {
                    Button("Stop Scanning") {
                        scanning = false
                        let reader = "1"
                        let result = viewModel.stopInventory(reader: reader)
                        print(result)
                        print(viewModel.apiDelegate.tags)
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            Divider().padding()
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Clear") {
                        viewModel.apiDelegate.clearTags()
                    }
                }
            }
        }
    }
}

