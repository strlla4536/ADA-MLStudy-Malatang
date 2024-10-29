//
//  AppState.swift
//  MalatangChallenge
//
//  Created by 김준수(엘빈) on 10/30/24.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func resetNavigation() {
        navigationPath = NavigationPath() // 최상위 화면으로 돌아감
    }
    
    func navigateToEndingView(score: Int) {
        navigationPath.append(score) // 특정 경로로 이동할 수 있도록 설정
    }
}
