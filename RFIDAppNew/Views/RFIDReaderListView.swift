//
//  RFIDReaderListViewModel.swift
//  RFIDAppNew
//
//  Created by RFID Lab on 5/10/24.
//

import Foundation
import SwiftUI

struct RFIDReaderListView: View {
    @ObservedObject var viewModel = RFIDViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.readers, id: \.self) { reader in
                Text(reader)
            }
            .navigationTitle("RFID Readers")
            .toolbar {
                Button("Refresh") {
                    viewModel.getAvailableReaderList()
                }
            }
        }
    }
}
