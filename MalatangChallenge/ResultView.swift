//
//  ResultView.swift
//  MalatangChallenge
//
//  Created by 김준수(엘빈) on 10/28/24.
//

import SwiftUI

struct ResultView: View {
    let score: Int
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Image("ScoreBG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            VStack {
                Text("\(score)점")
                    .font(.custom("DNFBitBitv2", size: 70))
                    .foregroundStyle(Color.white)
                    .shadow(color: .black, radius: 1, x: 4, y: 4)
                    .padding(.top, 50)
                
                HStack(spacing: 10) {
                    if score <= 60 {
                        Image("Star")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Image("Star2")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Image("Star2")
                            .resizable()
                            .frame(width: 80, height: 80)
                    } else if score >= 61 && score <= 80 {
                        Image("Star")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Image("Star")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Image("Star2")
                            .resizable()
                            .frame(width: 80, height: 80)
                    } else if score > 80 {
                        Image("Star")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Image("Star")
                            .resizable()
                            .frame(width: 80, height: 80)
                        Image("Star")
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                }
                .padding(.top, 1)
            }
            .padding(.top, 100)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    appState.navigateToEndingView(score: score)
                }
            }
        }
    }
}

#Preview {
    ResultView(score: 100) // 임의의 점수 100을 설정
        .environmentObject(AppState())
}
