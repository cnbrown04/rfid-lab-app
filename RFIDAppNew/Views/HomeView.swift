//
//  HomeView.swift
//  RFIDAppNew
//
//  Created by RFID Lab on 5/16/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("To get started, click Inventory on the bottom navigation bar.")
                .font(.headline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.gray)
            Spacer()
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Link(destination: URL(string: "https://www.github.com/cnbrown04/rfid-lab-app")!) {
                    Image("Github")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color.blue)
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Link(destination: URL(string: "https://rfid.auburn.edu")!) {
                    Image("Auburn")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color.blue)
                }
            }
        }
    }
}
