//
//  SettingsView.swift
//  RFIDLabSwift
//
//  Created by RFID Lab on 5/9/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @State private var scannerIndex = 0
    @ObservedObject var viewModel = RFIDViewModel()
    
    var body: some View {
        let readers = viewModel.getAvailableReaderList()
        NavigationView {
            Form {
                Section(header: Text("SCANNER OPTIONS"), content: {
                    HStack {
                        Image(systemName: "qrcode.viewfinder")
                        Picker(selection: $scannerIndex, label: Text("Scanner")) {
                            Text("Pick a scanner").tag(0)
                            ForEach(readers) { reader in
                                Text(reader.name).tag(Int(reader.id))
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    if viewModel.isActiveReader() {
                        Button("Connected") {
                            // Handle connected action
                        }
                        .frame(maxWidth: .infinity, alignment: .center).padding()
                    } else {
                        Button("Connect") {
                            let result = viewModel.connectToReader(reader: scannerIndex)
                        }
                        .frame(maxWidth: .infinity, alignment: .center).padding()
                    }
                })
            }
        }
        .navigationBarTitle("Settings")
    }
}
//#Preview {
//    AnyView(SettingsView())
//}
