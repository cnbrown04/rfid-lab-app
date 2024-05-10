//
//  TestingView.swift
//  RFIDLabSwift
//
//  Created by RFID Lab on 5/9/24.
//

import Foundation
import SwiftUI

struct TestingView: View {
    @State private var storeArea: String = ""
    @State public var readUPC: Float = 0
    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            Text("Store Area")
            TextField("Click here", text: $storeArea)
                .textFieldStyle(.roundedBorder)
        })
        .padding()
    }
}

#Preview {
    AnyView(TestingView())
}
