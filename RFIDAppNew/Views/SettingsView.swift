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
    @State var label = "Connect"
    @ObservedObject var viewModel = RFIDViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("SCANNER OPTIONS"), content: {
                    HStack {
                        Image(systemName: "qrcode.viewfinder")
                        Picker(selection: $scannerIndex, label: Text("Scanner")) {
                            let readers = viewModel.getAvailableReaderList()
                            Text("Pick a Scanner").tag(0)
                            ForEach(0..<readers.count, id: \.self) { index in
                                Text("\(readers[index].name) ").tag(index+1)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    Button(label) {
                        let result = viewModel.connectToReader(reader: scannerIndex)
                        if (result) {
                            label = "Connected"
                        } else {
                            label = "Failed!"
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center).padding()
                })
            }
        }
        .navigationBarTitle("Settings")
    }
}
//#Preview {
//    AnyView(SettingsView())
//}
