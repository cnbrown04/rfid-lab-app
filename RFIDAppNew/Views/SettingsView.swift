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
        NavigationView {
            Form {
                Section(header: Text("SCANNER OPTIONS"), content: {
                    HStack {
                        Image(systemName: "qrcode.viewfinder")
                        Picker(selection: $scannerIndex, label: Text("Scanner")) {
                            let readers = viewModel.getAvailableReaderList()
    
                            ForEach(readers) { reader in
                                Text(reader.name)
                            }
                        }
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
