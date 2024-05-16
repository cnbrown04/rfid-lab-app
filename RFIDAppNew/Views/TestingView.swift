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
        }
    }
}

//#Preview {
//    AnyView(TestingView())
//}
