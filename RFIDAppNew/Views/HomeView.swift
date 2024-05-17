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
            Text("To get started, click Settings on the bottom navigation bar to connect to a reader.")
                .font(.headline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.gray)
                .padding(.horizontal)
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
