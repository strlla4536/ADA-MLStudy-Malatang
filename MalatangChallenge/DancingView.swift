//
//  DancingView.swift
//  MalatangChallenge
//
//  Created by 규북 on 10/27/24.
//

import SwiftUI
import AVKit

struct DancingView: View {
    private let player: AVPlayer = {
        if let filePath = Bundle.main.path(forResource: "Main", ofType: "mp4") {
            let fileURL = URL(fileURLWithPath: filePath)
            return AVPlayer(url: fileURL)
        } else {
            fatalError("동영상을 찾을 수 없습니다.")
        }
    }()

    @State private var navigateToResultView = false
    @State private var score: Int = 0
    private let scoreManager = Score() // Score 인스턴스 생성
    private let detecter = Detecter() // Detecter 인스턴스 생성

    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .ignoresSafeArea(.all)
                .onAppear {
                    player.play()
                    addPlayerEndObserver()
                }

            VStack {
                HStack {
                    CameraView(cameraPosition: .front, detecter: detecter)
                        .frame(width: 120, height: 213.33)
                        .background(Color.gray.opacity(0.7))
                        .cornerRadius(8)
                        .padding(.top, 30)
                        .padding(.leading, 20)

                    Spacer() // HStack 내에서의 남은 공간을 사용
                }

                Spacer() // 하단 여백
            }
        }
        .fullScreenCover(isPresented: $navigateToResultView) {
            ResultView(score: score)
        }
    }

    private func addPlayerEndObserver() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            navigateToResultView = true
        }
    }
}

#Preview {
    DancingView()
}
