//
//  ContentView.swift
//  RFIDLabSwift
//
//  Created by RFID Lab on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        NavigationLink(destination: AuditView(), label: {
                            VStack {
                                Label("Audit", systemImage: "list.clipboard.fill")
                                Button(action: {}) {
                                    
                                }
                                .frame(width: 100)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(8)
                        })
                        NavigationLink(destination: RFIDReaderListView(), label: {
                            VStack {
                                Label("Testing", systemImage: "testtube.2")
                                Button(action: {}) {
                                    
                                }
                                .frame(width: 100)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.orange)
                            .cornerRadius(8)
                        })
                    }
                    HStack {
                        NavigationLink(destination: SettingsView(), label: {
                            VStack {
                                Label("Settings", systemImage: "gearshape.fill")
                                Button(action: {}) {
                                    
                                }
                                .frame(width: 240)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(8)
                        })
                    }
                    Spacer()
                        .frame(height: 450)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
