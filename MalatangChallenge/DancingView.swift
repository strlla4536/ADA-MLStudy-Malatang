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
        if let filePath = Bundle.main.path(forResource: "Main", ofType: "mp4") {
            let fileURL = URL(fileURLWithPath: filePath)
            return AVPlayer(url: fileURL)
        } else {
            fatalError("동영상을 찾을 수 없습니다.")
        }
    }()
    
    @State private var navigateToResultView = false
    @State private var score: Int = 0
       private let modelManager = MLModelManager()

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
        .fullScreenCover(isPresented: $navigateToResultView) {
            ResultView(score: score)
        }
    }
    
    private func addPlayerEndObserver() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            score = 60 // 임의의 점수 설정, 추후 수정 필요
            navigateToResultView = true
        }
    }
}


struct CameraView: UIViewRepresentable {
  private let captureSession = AVCaptureSession()
  
  func updateUIView(_ uiView: UIView, context: Context) {
    // 필요 시 업데이트 작업 추가
  }
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    
    // 프리뷰를 위한 더미 뷰 - 카메라를 대신할 간단한 PlaceholderView
#if targetEnvironment(simulator)
    let placeholderLabel = UILabel()
    placeholderLabel.text = "프리뷰라 카메라 안됨"
    placeholderLabel.textAlignment = .center
    placeholderLabel.textColor = .white
    placeholderLabel.backgroundColor = .gray
    placeholderLabel.frame = view.bounds
    view.addSubview(placeholderLabel)
    
    // 제약 조건을 추가하여 placeholderLabel이 부모 뷰에 꽉 차도록 설정
    NSLayoutConstraint.activate([
      placeholderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      placeholderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      placeholderLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
      placeholderLabel.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
    
#else
    // 실제 기기에서 실행되면 카메라 세팅
    guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
          let input = try? AVCaptureDeviceInput(device: camera) else {
      return view
    }
    
    captureSession.addInput(input)
    
    let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer.frame = view.bounds
    previewLayer.videoGravity = .resizeAspectFill
    view.layer.addSublayer(previewLayer)
    
    captureSession.startRunning()
#endif
    
    return view
  }
  
  
  
  func dismantleUIView(_uiView: UIView, coordinator: ()) {
    captureSession.stopRunning()
  }
}




#Preview {
  DancingView()
}
