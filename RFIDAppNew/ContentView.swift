//
//  ContentView.swift
//  RFIDLabSwift
//
//  Created by RFID Lab on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var defaultSel = 3
   
    var body: some View {
        TabView(selection: $defaultSel) {
            // Audit View Stack
            NavigationStack {
                AuditView()
                    .navigationBarTitle("Audit")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Audit", systemImage: "list.bullet.clipboard.fill")
            }.tag(1)
            
            // Inventory Stack
            NavigationStack {
                InventoryView()
                    .navigationBarTitle("Inventory")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Inventory", systemImage: "tray.2.fill")
            }.tag(2)
            
            // Home Page Stack
            NavigationStack {
                HomeView()
                    .navigationBarTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }.tag(3)
            
            // Testing View Stack
            NavigationStack {
                TestingView()
                    .navigationBarTitle("Testing")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Testing", systemImage: "testtube.2")
            }.tag(4)
            
            // Settings Stack
            NavigationStack {
                SettingsView(versionString: AppVersionProvider.appVersion(), appIcon: AppIconProvider.appIcon())
                    .navigationBarTitle("Settings")
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }.tag(5)
        }
    }
}

#Preview {
    ContentView()
}
