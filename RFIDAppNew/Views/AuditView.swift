//
//  AuditView.swift
//  RFIDLabSwift
//
//  Created by RFID Lab on 5/9/24.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

struct AuditView: View {
    @State private var storeArea: String = ""
    @State private var selectedTag: String = "Poop"
    let tags = ["Poop", "poop2", "poop3"]
    
    var body: some View {
        List {
            Section(header: Text("Store Area")) {
                TextField("Enter store area here", text: $storeArea)
                    .lineLimit(1)
            }
            
            Section(header: Text("Scan Results")) {
                VStack {
                    Text("UPC")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)
                    Text("123456789")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color(UIColor.gray))
                }
                VStack {
                    Text("EPC")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)
                    Text("123456789")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color(UIColor.gray))
                }
                VStack {
                    Text("TID")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)
                    Text("123456789")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color(UIColor.gray))
                }
                VStack {
                    Text("EXTRACTED UPC")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)
                    Text("123456789")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color(UIColor.gray))
                }
            }
            
            Section(header: Text("Tag Type")) {
                Picker("Tag Type", selection: $selectedTag) {
                    ForEach(tags, id: \.self) { i in
                        HStack {
                            Text(i)
                        }.tag(i)
                    }
                }.pickerStyle(.navigationLink)
            }
            
            Button("Save") {
                let _ = print("poopy")
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        Divider().padding([.bottom, .horizontal])
    }
}

#Preview {
    AnyView(AuditView())
}
