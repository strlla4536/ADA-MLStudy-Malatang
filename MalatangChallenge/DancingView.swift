//
//  DancingView.swift
//  MalatangChallenge
//
//  Created by 규북 on 10/27/24.
//

import SwiftUI
import AVKit
import AVFoundation

struct DancingView: View {
  private let player: AVPlayer = {
    if let filePath = Bundle.main.path(forResource: "IMG_5179", ofType: "MOV") {
      let fileURL = URL(fileURLWithPath: filePath)
      return AVPlayer(url: fileURL)
    } else {
      fatalError("동영상을 찾을 수 없습니다.")
    }
  } ()
  
    var body: some View {
      ZStack {
        VideoPlayer(player: player)
          .ignoresSafeArea(.all)
          .onAppear{
            player.play() //DancingView로 전환되면 자동으로 영상 재생
          }
      
        VStack {
          HStack {
            Spacer()
//            CameraView()
//              .frame(width: 120, height: 213.33)
//              .padding()
            Spacer()
          }
        }
      }
    }
}

#Preview {
    DancingView()
}
