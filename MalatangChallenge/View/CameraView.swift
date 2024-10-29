//
//  CameraView.swift
//  MalatangChallenge
//
//  Created by 규북 on 10/30/24.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewRepresentable {
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    
#if targetEnvironment(simulator)
    let placeholderLabel = UILabel()
    placeholderLabel.text = "시뮬레이터에서는 카메라를 사용할 수 없습니다."
    placeholderLabel.textAlignment = .center
    placeholderLabel.textColor = .white
    placeholderLabel.backgroundColor = .gray
    placeholderLabel.frame = view.bounds
    view.addSubview(placeholderLabel)
#else
//    cameraManager.setupCamera(for: view)
#endif
    
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {
    
  }
  
  func dismantleView(_ uiView: UIView, coordinator: ()) {
    
  }
  
}

#Preview {
  CameraView()
}
