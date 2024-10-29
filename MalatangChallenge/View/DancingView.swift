//
//  DancingView.swift
//  MalatangChallenge
//
//  Created by 규북 on 10/27/24.
//

import SwiftUI
import AVKit


struct DancingView: View {
  @StateObject private var viewModel = DancingViewModel()
  
    var body: some View {
        ZStack {
          if let player = viewModel.getPlayer() {
            VideoPlayer(player: player)
              .ignoresSafeArea(.all)
              .onAppear {
                viewModel.playVideo()
              }
              .onDisappear {
                // 필요한 동작 추가 (예: 카메라 세션 정지 등)
              }
          }
            
            VStack {
                HStack {
                    CameraView()
                        .frame(width: 120, height: 213.33)
                        .background(Color.gray)
                        .padding(.top, 30)
                    
                    Spacer()
                }
                .padding(.leading, 10)
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $viewModel.navigateToResultView) {
          ResultView(score: viewModel.score)
        }
        .onAppear {
          viewModel.initializePlayer()
        }
    }
}



#Preview {
  DancingView()
}
