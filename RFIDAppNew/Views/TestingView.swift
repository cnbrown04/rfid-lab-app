//
//  TestingView.swift
//  RFIDLabSwift
//
//  Created by RFID Lab on 5/9/24.
//

import Foundation
import SwiftUI

struct TestingView: View {
    @StateObject var viewModel = RFIDViewModel()
    @State var scanFor: MemoryBank = .epc
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.apiDelegate.tags, id: \.self) { tag in
                    Text(tag)
                }
                
                HStack {
                    Picker("Scan for:", selection: $scanFor) {
                        ForEach(MemoryBank.allCases) { option in
                            Text(String(describing: option))
                        }
                    }.pickerStyle(.segmented)
                }.padding()
                HStack {
                    Button(action: {
                        let reader = "1"
                        let memoryBank = MemoryBank.epc // Use the appropriate memory bank
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
                    }) {
                        Text("Start Reading")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        let reader = "1"
                        let result = viewModel.stopInventory(reader: reader)
                        print(result)
                        print(viewModel.apiDelegate.tags)
                    }) {
                        Text("Stop Reading")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("Inventory")
    }
}

//#Preview {
//    AnyView(TestingView())
//}
