//
//  TestingView.swift
//  RFIDLabSwift
//
//  Created by RFID Lab on 5/9/24.
//

import Foundation
import SwiftUI

struct TestingView: View {
    @EnvironmentObject var viewModel: RFIDViewModel
    
    var body: some View {
        Image(systemName: viewModel.apiDelegate.isTriggerPulled ? "checkmark.circle.fill" : "xmark.circle.fill")
            .resizable()
            .foregroundColor(viewModel.apiDelegate.isTriggerPulled ? .green : .red)
            .frame(width: 50, height: 50)
    }
}

//#Preview {
//    AnyView(TestingView())
//}
