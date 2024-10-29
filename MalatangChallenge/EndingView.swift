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


