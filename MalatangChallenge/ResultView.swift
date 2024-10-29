//
//  ResultView.swift
//  MalatangChallenge
//
//  Created by 김준수(엘빈) on 10/28/24.
//

import SwiftUI

struct ResultView: View {
    let score: Int
    @State private var navigateToEndingView = false

    var body: some View {
        VStack {
            Text("Your Score: \(score)")
                .font(.largeTitle)
                .padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                navigateToEndingView = true
            }
        }
        .fullScreenCover(isPresented: $navigateToEndingView) {
            EndingView(score: score)
        }
    }
}

