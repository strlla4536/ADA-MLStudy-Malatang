//
//  MalatangChallengeApp.swift
//  MalatangChallenge
//
//  Created by 규북 on 10/27/24.
//

import SwiftUI

@main
struct MalatangChallengeApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
