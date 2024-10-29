//
//  EndingView.swift
//  MalatangChallenge
//
//  Created by 김준수(엘빈) on 10/28/24.
//

import SwiftUI
import AVKit

struct EndingView: View {
    let score: Int
    @EnvironmentObject var appState: AppState
    
    private var videoName: String {
        switch score {
        case 0...60:
            return "failed"
        case 61...80:
            return "middle"
        case 81...100:
            return "success"
        default:
            return "failed"
        }
    }
    
    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            if let player = player {
                VideoPlayer(player: player)
                    .ignoresSafeArea()
                    .onAppear {
                        player.play()
                    }
            } else {
                Text("Loading video...")
                    .onAppear {
                        loadPlayer()
                    }
            }
            
            VStack {
                Spacer()
                
                Button(action: {
                    appState.resetNavigation() // 네비게이션 경로 초기화
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 240, height: 83.91608)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 0.98, green: 0.85, blue: 0.17), location: 0.00),
                                        Gradient.Stop(color: Color(red: 0.94, green: 0.54, blue: 0.02), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.5, y: 0),
                                    endPoint: UnitPoint(x: 0.5, y: 1)
                                )
                            )
                            .cornerRadius(167.83217)
                            .overlay(
                                RoundedRectangle(cornerRadius: 167.83217)
                                    .inset(by: 1.5)
                                    .stroke(.black, lineWidth: 3)
                            )
                        Text("처음으로")
                            .font(.custom("DNFBitBitv2", size: 30))
                            .foregroundStyle(Color.black)
                    }
                }
                .padding(.bottom, 30)
            }
        }
    }
    
    private func loadPlayer() {
        if let filePath = Bundle.main.path(forResource: videoName, ofType: "mp4") {
            let fileURL = URL(fileURLWithPath: filePath)
            player = AVPlayer(url: fileURL)
        } else {
            fatalError("동영상을 찾을 수 없습니다.")
        }
    }
}

#Preview {
    EndingView(score: 100) // 임의의 점수 80을 설정
        .environmentObject(AppState())
}
