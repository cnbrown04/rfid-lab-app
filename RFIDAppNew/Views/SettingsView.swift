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
    @State private var beeperIndex = 0
    @State var label = "Connect"
    @EnvironmentObject var viewModel: RFIDViewModel
    @State private var connectAlert = false
    @State private var failAlert = false
    @State private var alrConnectedAlert = false
    let versionString: String
    let appIcon: String
    
    var body: some View {
        let readers = viewModel.getAvailableReaderList()
        Form {
            Section(header: Text("SCANNER CONNECTION"), content: {
                HStack {
                    Image(systemName: "qrcode.viewfinder")
                    Picker(selection: $scannerIndex, label: Text("Scanner")) {
                        Text("Pick A Scanner").tag(0)
                        ForEach(readers) { reader in
                            Text(reader.name).tag(Int(reader.id))
                        }
                    }
                    .pickerStyle(.menu)
                }
                if viewModel.isActiveReader() {
                    Button("Connected") {
                        alrConnectedAlert = true
                    }
                    .frame(maxWidth: .infinity, alignment: .center).padding()
                    .foregroundColor(.green)
                    .alert("Already connected!", isPresented: $alrConnectedAlert) {
                        Button("OK") { }
                    }
                } else {
                    Button(label) {
                        let result = viewModel.connectToReader(reader: scannerIndex)
                        if (result) {
                            label = "Connected"
                            connectAlert = true
                            scannerIndex = 0
                        } else {
                            label = "Failed"
                            failAlert = true
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center).padding()
                    .alert("Connected!", isPresented: $connectAlert) {
                        Button("OK") {}
                    }
                    .alert("Failure!", isPresented: $failAlert) {
                        Button("OK") {}
                    }
                }
            })
            
            if (label == "Connected") {
                Section(header: Text("SCANNER OPTIONS"), content: {
                    Picker(selection: $beeperIndex, label: Text("Beeper Volume")) {
                        Text("Loud").tag(0)
                        Text("Medium").tag(1)
                        Text("Quiet").tag(2)
                    }
                })
            }
            
            Section(header: Text("APP INFO"), content: {
                VStack {
                    HStack(alignment: .center, spacing: 12) {
                        // App icons can only be retrieved as named `UIImage`s
                        // https://stackoverflow.com/a/62064533/17421764
                        if let image = UIImage(named: appIcon) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        VStack(alignment: .leading) {
                            Text("Version")
                                .fontWeight(.semibold)
                                .font(.headline)
                            Text("v\(versionString)")
                                .fontWeight(.regular)
                                .font(.subheadline)
                        }
                        .foregroundColor(.primary)
                    }
                    .fixedSize()
                    .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    Text("Last Updated on 05/16/2024")
                        .fontWeight(.light)
                        .font(.caption)
                }.padding()
            })
        }
    }
}
//#Preview {
//    AnyView(SettingsView())
//}
