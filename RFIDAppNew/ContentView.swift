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
            AuditView()
                .tabItem {
                    Label("Audit", systemImage: "list.bullet.clipboard.fill")
                }
                .tag(1)
            InventoryView()
                .tabItem {
                    Label("Inventory", systemImage: "tray.2.fill")
                }.tag(2)
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }.tag(3)
            TestingView()
                .tabItem {
                    Label("Testing", systemImage: "testtube.2")
                }.tag(4)
            SettingsView(versionString: AppVersionProvider.appVersion(), appIcon: AppIconProvider.appIcon())
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }.tag(5)
        }
    }
}

#Preview {
    ContentView()
}
