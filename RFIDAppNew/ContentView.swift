//
//  ContentView.swift
//  RFIDLabSwift
//
//  Created by RFID Lab on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RFIDViewModel()
    @State private var defaultSel = 3
   
    var body: some View {
        TabView(selection: $defaultSel) {
            // Audit View Stack
            NavigationStack {
                AuditView()
                    .navigationBarTitle("Audit")
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(viewModel)
            }
            .tabItem {
                Label("Audit", systemImage: "list.bullet.clipboard.fill")
            }.tag(1)
            
            // Inventory Stack
            NavigationStack {
                InventoryView()
                    .navigationBarTitle("Inventory")
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(viewModel)
            }
            .tabItem {
                Label("Inventory", systemImage: "tray.2.fill")
            }.tag(2)
            
            // Home Page Stack
            NavigationStack {
                HomeView()
                    .navigationBarTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(viewModel)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }.tag(3)
            
            // Testing View Stack
            NavigationStack {
                TestingView()
                    .navigationBarTitle("Testing")
                    .navigationBarTitleDisplayMode(.inline)
                    .environmentObject(viewModel)
            }
            .tabItem {
                Label("Testing", systemImage: "testtube.2")
            }.tag(4)
            
            // Settings Stack
            NavigationStack {
                SettingsView(versionString: AppVersionProvider.appVersion(), appIcon: AppIconProvider.appIcon())
                    .navigationBarTitle("Settings")
                    .environmentObject(viewModel)
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
