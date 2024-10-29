//
//  DancingViewModel.swift
//  MalatangChallenge
//
//  Created by 규북 on 10/30/24.
//

import SwiftUI
import Foundation
import AVFoundation

class DancingViewModel: ObservableObject {
  @Published var navigateToResultView = false
  @Published var score: Int = 0
  private let modelManager = MLModelManager()
  private var player: AVPlayer?
  
  func initializePlayer() {
    if let filePath = Bundle.main.path(forResource: "Main", ofType: "mp4") {
      let fileURL = URL(fileURLWithPath: filePath)
      player = AVPlayer(url: fileURL)
    } else {
      fatalError("동영상을 찾을 수 없습니다.")
    }
  }
  
  func playVideo() {
    player?.play()
    addPlayerEndObserver()
  }
  
  private func addPlayerEndObserver() {
    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { [weak self] _ in
      self?.score = 0
      self?.navigateToResultView = true
      
    }
  }
  
  func getPlayer() -> AVPlayer? {
    return player
  }
}

